{-# LANGUAGE RankNTypes #-}
import Prelude hiding ((*), (/), (-))
import Data.Char (isSpace)
import Data.List
import Data.Char
import Control.Monad (when) ---- For I/O stuff
import System.Exit (exitSuccess) ---- So you don't hijack the user's computer

------ Arbitrary predicate data type that can represent atomic predicates as well as 
---- recursively defined predicates of logical operations
data Predicate
    = Atomic String  -- Atomic predicate (cannot be reduced further through AND/OR/NOT)
    | And Predicate Predicate          -- Conjunction
    | Or Predicate Predicate           -- Disjunction
    | Not Predicate                    -- Negation
    deriving (Eq)

instance Show Predicate where
    show (Atomic s)      = s
    show (And p1 p2)     = "(" ++ show p1 ++ "∧" ++ show p2 ++ ")"
    show (Or p1 p2)      = "(" ++ show p1 ++ "∨" ++ show p2 ++ ")"
    show (Not p)         = "¬" ++ show p

isAnd :: Predicate -> Bool
isAnd (And _ _) = True
isAnd _ = False

isOr :: Predicate -> Bool
isOr (Or _ _) = True
isOr _ = False

isNot :: Predicate -> Bool
isNot (Not _) = True
isNot _ = False

isAtom :: Predicate -> Bool
isAtom p = not $ or $ map ($ p) [isAnd, isOr, isNot]


-------- Decompose is a very important function. It serves to unwrap nested predicates, and acts as
---- the inverse operation of whatever operation has been applied to the predicate. As such:
---- (a OR b) |= c -> [ (a |= c), (b |= c) ], and it is expected for the lists to be deconstructed
---- by whoever is calling this function to deal with the branching predicates properly.
decompose :: Predicate -> [Predicate]
decompose (And p1 p2) = [p1, p2]
decompose (Or p1 p2)  = [p1, p2]
decompose (Not p)     = [p]
decompose (Atomic _)  = []   -- { Atomic predicates cannot have components. }



-- List concatenation for Predicates
(|=) :: [Predicate] -> [Predicate] -> ([Predicate], [Predicate])
(|=) = (,)

-- Logical conjunction -> And constructor
(/) :: Predicate -> Predicate -> Predicate
(/) = And

-- Logical disjunction -> Or constructor
(*) :: Predicate -> Predicate -> Predicate
(*) = Or

-- Logical negation -> Not constructor
(-) :: Predicate -> Predicate
(-) = Not


-- Fixity declarations for operators
infixr 1 /  -- Conjunction 
infixr 1 *  -- Disjunction
infixl 0 |= -- List concatenation (left-associative)
infix  2 -  -- Negation (highest precedence)



--- Main syllogism solver

type IsRule = ( ([Predicate], [Predicate]) -> Bool )
type Rule = ( ([Predicate], [Predicate]) -> ([Predicate], [Predicate]) )
type Branch = ( ([Predicate], [Predicate]) -> [ ([Predicate], [Predicate]) ] )

------ Assumptions of "p |= q" returns [ "|= p1, q1", "|= p2, q2"...]
---- I am not sure why I insisted so strongly on a pair of predicate lists for some functions, 
---- but my decision-making skills aren't too great at the moment. 
---- My poor function...
assumptionsOf :: ([Predicate], [Predicate]) -> [Predicate]
assumptionsOf (p,q) 
 | isDuplicate (p,q) = nub $ assumptionsOf (removeDuplicate (p,q) )
 | isIdentity (p,q) = []
 | isLcon (p,q) = nub $ assumptionsOf (doLcon (p,q) )
 | isRcon (p,q) = nub $ assumptionsOf (doRcon (p,q) )
 | isLand (p,q) = nub $ assumptionsOf (doLand (p,q) )
 | isRor (p,q) = nub $ assumptionsOf (doRor (p,q) )
 | isLor (p,q) = nub $ concat $ map assumptionsOf $ doLor (p,q)
 | isRand (p,q) = nub $ concat $ map assumptionsOf $ doRand (p,q)
 | otherwise = nub $ q ++ map (-) p ---- Assumption



---- Is/Do functions:

isFallacy :: IsRule
isFallacy (p,q) =
 (or [pi == (head $ decompose pj) | pi <- p, pj <- p, isNot pj ] )
 || 
 (or [qi == (head $ decompose qj) | qi <- q, qj <- q, isNot qj ] )

isDuplicate :: IsRule
isDuplicate (p,q) = 
  (or [ p!!i == p!!j | i <- [0..subtract 1 $ length p], j <- [0..subtract 1 $ length p], i /= j ] )
  || 
  (or [ q!!i == q!!j | i <- [0..subtract 1 $ length q], j <- [0..subtract 1 $ length q], i /= j ] )

removeDuplicate :: Rule
removeDuplicate (p,q) = (nub p, nub q)

----

isIdentity :: IsRule
isIdentity (p,q) = 
 or [ pi == qi | pi <- p, qi <- q ]

----

isLcon :: IsRule
isLcon = not . null . negs . fst

doLcon :: Rule
doLcon (p,q) = (nonNegs p, q ++ negs p)

----

isRcon :: IsRule
isRcon = not . null . negs . snd

doRcon :: Rule
doRcon (p,q) = (p ++ negs q, nonNegs q)

----

isLand :: IsRule
isLand = not . null . ands . fst

doLand :: Rule
doLand (p,q) = (nonAnds p ++ (concat $ ands p), q)

----

isRor :: IsRule
isRor = not . null . ors . snd

doRor :: Rule
doRor (p,q) = (p, nonOrs q ++ (concat $ ors q))

----

isLor :: IsRule
isLor = not . null . ors . fst

-------- This was ALMOST a massive pain.
---- G,(A OR B),(C OR D) |= D eventually branches to G, [[A,C],[A,D],[B,C],[B,D]]. Yes, this is the 
---- cartesian product of these expressions. Luckily enough, the built-in sequence function can
---- output the n-ary cartesian product just like that.
doLor :: Branch
doLor (p,q) = [ (branch ++ nonOrs p, q) | branch <- (sequence $ ors p) ]

----

isRand :: IsRule
isRand = not . null . ands . snd

---- Refer to doLor
doRand :: Branch
doRand (p,q) = [ (p, branch ++ nonAnds q) | branch <- (sequence $ ands q) ]


-------- Helper functions


-------- Component of ors, but returns single predicates rather than pairs. 
---- We do not decompose anything for components, as we are not operating on them in the function
nonOrs :: [Predicate] -> [Predicate]
nonOrs p = filter (not . isOr) p

---- Refer to nonOrs
nonAnds :: [Predicate] -> [Predicate]
nonAnds p = filter (not . isAnd) p

---- Component of negs. 
nonNegs :: [Predicate] -> [Predicate]
nonNegs p = filter (not . isNot) p

-------- Returns the list of all decomposed pairs in p. Is not concatenated so that we can use a
---- neat little trick for doLor and doRand to get the cartesian product very easily.
---- e.g. ors [p1, p2, p3a OR p3b...] returns [[p3a,p3b]...]
ors :: [Predicate] -> [[Predicate]]
ors p = map decompose $ filter isOr p

---- Refer to ors
ands :: [Predicate] -> [[Predicate]]
ands p = map decompose $ filter isAnd p

-------- Returns the list of all decomposed negatives in p. Is concatenated, as we do not want 
---- something like [[p1],[p2]...]
---- for [p1, p2, NOT p3...] returns [p3...]
negs :: [Predicate] -> [Predicate]
negs p = concat $ map decompose $ filter isNot p



-- Build from input string
build :: String -> ([Predicate], [Predicate])
build e = parseEntailment (tokenize e)

-- Tokenize input string
tokenize :: String -> [String]
tokenize [] = []
tokenize ('(':xs) = "(":tokenize xs
tokenize (')':xs) = ")":tokenize xs
tokenize ('-':xs) = "-":tokenize xs
tokenize ('/':xs) = "/":tokenize xs
tokenize ('*':xs) = "*":tokenize xs 
tokenize ('|':'=':xs) = "|=":tokenize xs  -- Entailment
tokenize (x:xs)
    | isAlpha x  = [x]:tokenize xs    -- Assumes predicates are single letters. If not, they ignore everything after. 
    | otherwise  = tokenize xs        -- Ignore other characters (like spaces)


parseEntailment :: [String] -> ([Predicate], [Predicate])
parseEntailment tok =
    case break (== "|=") tok of
        (left, ["|="])       -> ( [], [Not (parseExpr left)] )  ---- "p |=" <-> "|= -p"
        (left, ("|=":right)) -> ( [parseExpr left], [parseExpr right] )  ---- "p |= q"
        _                    -> ( [], [parseExpr tok] )  ---- "|= p"

-- Parsing w/ parentheses support
parseExpr :: [String] -> Predicate
parseExpr = parseOr

-- Parsing ors
parseOr :: [String] -> Predicate
parseOr tokens =
    let (left, rest) = parseAnd tokens
    in case rest of
        ("*":xs) -> Or left (parseOr xs)  -- Recursive
        _        -> left

-- Parsing ands
parseAnd :: [String] -> (Predicate, [String])
parseAnd tokens =
    let (left, rest) = parseNot tokens
    in case rest of
        ("/":xs) -> (And left (fst (parseAnd xs)), snd (parseAnd xs))  -- Recursive
        _        -> (left, rest)

-- Parsing nots
parseNot :: [String] -> (Predicate, [String])
parseNot ("-":xs) = let (p, rest) = parseAtomic xs in (Not p, rest)
parseNot tokens   = parseAtomic tokens

-- Parsing atomics (w/ parentheses)
parseAtomic :: [String] -> (Predicate, [String])
parseAtomic ("(":xs) =
    let (inside, rest) = break (== ")") xs
    in case rest of
        (")":remaining) -> (parseExpr inside, remaining)  -- Parse inside parentheses
        _               -> error "Mismatched parentheses."
parseAtomic (x:xs)
    | isAlpha (head x) = (Atomic x, xs)  -- Atomic predicate
    | otherwise        = error "Invalid token in atomic expression."
parseAtomic [] = error "Unexpected end of input."

-- Helper for invalid patterns (like p*****p)
validateTokens :: [String] -> Bool
validateTokens tokens = validate tokens False

validate :: [String] -> Bool -> Bool
validate [] _ = True
validate ("*":"/":_) _ = False  -- Idk what Im doing anymore
validate (_:xs) _ = validate xs False



-- Main loop
mainLoop :: Bool -> IO ()
mainLoop showHelp = do
  when showHelp $ putStrLn $ unlines [
      ">>Enter a single logical expression you assume to be true, like \"(p/q)*-q\".",
      ">>As a note, (/) is AND, (*) is OR, and (-) is NOT.",
      ">>All operations are processed such that the rightmost operation terminates first.",
      ">>If you don't like this, use parentheses when necessary.",
      ">>Operations have descending priority of (-), then (/ or *).",
      ">>All predicates must be alphabetical and a single character long.",
      ">>So \"p\" is fine but \"!\" and \"pp\" are not. (Break it if you want, I'm not your boss).",
      ">>If you don't like this thing saying the same thing every time, type \"stop\".",
      ">>If you just plainly don't like this thing in general, type \"quit\"."]

  putStrLn "Enter your expression:"
  input <- getLine

  case input of
    "stop" -> mainLoop False   -- Stop offering help
    "quit" -> exitSuccess      -- Quit 
    _      -> do
      let predicate = build input
      print predicate
      mainLoop showHelp        -- Keep waiting

-- Actual main
main :: IO ()
main = mainLoop True  -- Start with help message shown


------ Some tautologies that can be tested. Try writing their names out in the terminal, 
---- or applying assumptionsOf on them.

taut1 :: ([Predicate], [Predicate])
taut1 = ( [Atomic "a"], [Atomic "a"] ) 

taut2 :: ([Predicate], [Predicate])
taut2 = ( [Atomic "a"], [Atomic "b"] ) 

taut3 :: ([Predicate], [Predicate])
taut3 = ( [Or (Atomic "a") (Not (Atomic "b"))] , [And (Not (Atomic "a")) (Atomic "b")] ) 

taut4 :: ([Predicate], [Predicate])
taut4 = ( [], [Or (And (Or (Not(Atomic "p")) (Atomic "q")) (Not (Atomic "p"))) (Atomic "p") ])

taut5 :: ([Predicate], [Predicate])
taut5 = ( [] , [ Or (Not (And (Or (Not(Atomic "a")) (Atomic "b")) (Or (Not (Atomic "c")) (Atomic "b")))) (Or (Not (Atomic "a")) (Atomic "c")) ] )

taut6 :: ([Predicate], [Predicate])
taut6 = ( [], [And (Atomic "a") (Not (Atomic "a"))] )
