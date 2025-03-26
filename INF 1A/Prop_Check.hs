type Name = String

data Prop = Var Name 
          | F
          | T
          | Not Prop
          | Prop :|| Prop
          | Prop :&& Prop
          deriving Eq

p0 :: Prop
p0= Var "a" :&& Not (Var "a")

p1:: Prop
p1= (Var "a" :&& Var "b") :|| (Not (Var "a"):&& Not(Var "b"))

p2:: Prop
p2= (Var "a" :&& Not (Var "b") :&& (Var "c" :|| (Var "d" :&& Var "b")):|| (Not (Var "b") :&& Not (Var "a"))):&& Var "c"

par:: String -> String
par s = show "(" ++ s ++ ")"

instance Show Prop where
    show (Var x) = x
    show F = "F"
    show T = "T"
    show (Not p) = par ("not" ++ show p)
    show (p:|| q) = par (show p ++ "||" ++ show q)
    show (p:&& q) = par (show p ++ "&&" ++ show q)

type Valn = Name -> Bool
vn :: Valn
vn "a" = True
vn "b" = True
vn "c" = False
vn "d" = True

evalProp :: Valn -> Prop -> Bool
evalProp vn (Var x) = vn x
evalProp vn F = False
evalProp vn T = True
evalProp vn (Not p) = not (evalProp vn p)
evalProp vn (p :|| q) = evalProp vn p || evalProp vn q
evalProp vn (p :&& q) = evalProp vn p && evalProp vn q

type Names = [Name]
names:: Prop -> Names
names (Var x) = [x]
names F = []
names T = []
names (Not p) = names p
names (p :&& q) = nub2 (names p ++ names q)
names (p :|| q) = nub2 (names p ++ names q)

nub2 :: Eq a => [a] -> [a]
nub2 [] = []
nub2 (x:xs) | elem x xs = [x] ++ nub2 [a| a <- xs, a /= x]
            | otherwise = [x] ++ nub2 xs

empty:: Valn
empty y = error "undefined"

extend :: Valn -> Name -> Bool -> Valn
extend vn x b y |  x  == y =b
                |  otherwise = vn y

valns :: Names -> [Valn]
valns [] = [empty]
valns (x:xs) = [extend vn x bool | vn <- valns xs, bool <- [True, False]]

satisfiable  :: Prop -> Bool
satisfiable p = or [ evalProp vn p | vn <- valns (names p)]

