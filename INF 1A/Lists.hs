import Data.Char ()
import Text.ParserCombinators.ReadP ()
import Data.Maybe
import Data.List

nums :: [Int]
nums = [1..100]




--Try primelist and fibo3 that give lists of primes up to n and the first n fibonacci sequence terms

square = [x*x | x <- nums]


evencheck :: [Int]
evencheck = [if even x then x else x+1 | x <- nums]

evenchack :: [Int]
evenchack = [if even x then x-1 else x+1 | x <- nums]

thomasformula :: Int
thomasformula = product [x*x | x <- [1,2,3,4,4,5,6,7,8,8,5,4,3,5,3,2,2,6,3,4,3,3,3,3], odd x]

data Thing = R | S | T | U | V | W | X | Y | Z | Rabbit deriving (Eq, Show)
things :: [Thing]
things = [R, S, T, U, V, W, X, Y, Z, Rabbit]
type Predicate x = x -> Bool
isGreen :: Predicate Thing
isGreen R = True
isGreen S = True
isGreen x = x `elem` [R, S, T, Rabbit]

green :: [Bool]
green = [isGreen x | x <- things]

isTriangle :: Predicate Thing
isTriangle x = x `elem` [Y, Z, R, S, Rabbit]

greentriangle :: Thing -> Bool
greentriangle x = and [isGreen x && isTriangle x]


isdivisiblebyoneof :: Integer -> [Integer] -> [Bool]
isdivisiblebyoneof a xs = [a `mod` x == 0 | x <- xs , odd x || x==2, x `mod` 3 /= 0 || x == 3, x `mod` 5 /= 0 || x == 5,x `mod` 7 /= 0 || x == 7, x `mod` 11 /= 0 || x == 11, x `mod` 13 /= 0 || x == 13, x `mod` 17 /= 0 || x == 17 ]





newflrt :: Integer -> Integer
newflrt = round . (sqrt::Double->Double) . fromInteger 

listprimes :: [Integer] -> [Integer]
listprimes xs = [x | x<- xs, prime x == True, x>1]


listtwinprimes :: [Integer] -> [Integer]
listtwinprimes xs = [x | x<- xs, prime x == True && prime (x+2) == True || prime x == True && prime (x-2) == True, x>1]


numberslist :: Integer -> [Integer]
numberslist x = [1..x]

listprimeslessthan :: Integer -> [Integer]
listprimeslessthan x = listprimes (numberslist (x-1))

fibo :: Integer -> [Integer]
fibo 0 = [1]
fibo 1 = [1]
fibo n = head (fibo (n-1)) + head (fibo (n-2)): fibo (n-1)

fibo2 :: Integer -> [Integer]
fibo2 n | n<0 = []
        | n== 0 = [1]
        | n== 1 = [1,1]
        | otherwise = fibo (n-1) ++ [lasttwo ( fibo (n-1))]


lasttwo [] = 0
lasttwo list | length list == 1 = head list
             | otherwise = last list + (list !! ((length list) -2))


nextfibo :: [Integer] -> [Integer]
nextfibo list = list ++ [lasttwo list]


repeatuntilcantbedone :: ([a] -> [a]) ->  Int -> [a] -> [a]
repeatuntilcantbedone function n list | length (function (list)) == n = function list
                                      | otherwise = repeatuntilcantbedone (function) n (function list)



fibo3 :: Int -> [Integer]
fibo3 n | n <0 = error "wrong"
        | n == 0 = [1]
        | n == 1 = [1,1]
        | otherwise = repeatuntilcantbedone nextfibo n [1,1] 

oppositeorder :: [a] -> [a]
oppositeorder [] = []
oppositeorder [a] = [a]
oppositeorder (x:xs) = oppositeorder xs ++ [x]

headfibo :: Integer -> Integer
headfibo a = head (fibo a)

headless :: Integer -> Integer -> Bool
headless a b = headfibo a < b

evenfibo :: Integer -> [Integer]
evenfibo a = [x | x<- fibo a, even x]

threefives :: Integer -> [Integer]
threefives a = [x | x <- [1..a-1], x `mod` 3 == 0 || x `mod` 5 == 0 ]

divisibleby :: Integer -> Integer -> Bool
divisibleby a x = a `mod` x == 0


maybeprime :: Integer -> Bool
maybeprime t = elem True (isdivisiblebyoneof t [2..(newflrt t)])

primefactors :: Integer -> [Integer]
primefactors x = [a | a <- [1..x], divisibleby x a, prime a]

largestprimefactor :: Integer -> Integer
largestprimefactor x = last (primeFactorsOf x)

primeFactorsOf :: Integer -> [Integer]
primeFactorsOf n
  | n < 2 = []
  | n == 2 = [2]
  | otherwise = d : primeFactorsOf (n `div` d)
  where d = head [ i | i <- [2..n], n `mod` i == 0 ]


truncatable :: Integer -> [Integer]
truncatable a = [x | x<- [31..a], prime x ]

oddsRec :: [Integer] -> [Integer]
oddsRec []                 = []
oddsRec (x:xs) | odd x     = x:oddsRec xs
               | otherwise = oddsRec xs

summa :: [Integer] -> Integer
summa [] = 0
summa (x:xs) | odd x = x + summa xs
             | otherwise = summa xs

isRange :: Int -> Int -> [Int] -> [Int]
isRange a b xs = [x | x <- xs, x>= a, x<= b]

numberlistint :: Int -> [Int]
numberlistint x = [1..x]

prime3is :: Integer -> Bool
prime3is x = null [a | a <- [2..newflrt x], x `mod` a == 0]


isdivisibleby :: Integer -> Integer -> Bool
isdivisibleby a b  = a `mod` b == 0


primeis :: Integer -> [Integer]
primeis x | x <= 1 = []
          | x == 2 = [2]
          | x >= 3 && even x = primeis (x-1)
          | x >= 3 && odd x && isdivisiblebyoneof2 x (primeis (x-1))= primeis (x-1) ++ [x]
          | otherwise = primeis (x-1)

primesr :: Integer -> [Integer]
primesr x = []

nextprime :: Integer -> Integer
nextprime x = head [z | z <- [(x+1) ..], prime3is z]

primelist :: Integer -> [Integer]
primelist z= filter (<z) (nub [nextprime x | x <- [1..(z-1)]])

isdivisiblebyoneof2 :: Integer -> [Integer] -> Bool
isdivisiblebyoneof2 a xs = not (or [a `mod` x == 0 | x <- xs ])


nodoubles :: Eq a => [a] -> [a]
nodoubles [] = []
nodoubles (x:[]) = [x]
nodoubles (x:xs) | x == head xs = nodoubles xs
                 | x /= head xs = x: nodoubles xs

prime :: Integer -> Bool
prime t = maybeprime t == False && t /= 1

timepassing :: [Int]
timepassing = [378, 756..]

primenb :: [Int]
primenb = [2^312, 2^311 .. 2]

nextprime2 :: [Integer] -> [Integer]
nextprime2 list = list ++ [head [x | x <- [last list..], isdivisiblebyoneof2 x list]]

prime4 :: Integer -> [Integer]
prime4 n | n <2 = []
         | n==2 = [2]
         | otherwise = repeatuntilcantbedone2 nextprime2 n [2] 

repeatuntilcantbedone2 :: ([Integer] -> [Integer]) ->  Integer -> [Integer] -> [Integer]
repeatuntilcantbedone2 function n list | last (function (list)) >= n = function list
                                       | otherwise = repeatuntilcantbedone2 (function) n (function list)

nextprime3 :: [Integer] -> Integer
nextprime3 list = head [x | x <- [last list..], isdivisiblebyoneof2 x list]


isprime4 :: Integer -> Bool
isprime4 n | n <2 = False
           | n==2 = True
           | otherwise = isdivisiblebyoneof2 n (primeslessthan4 n)

primeslessthan4 :: Integer -> [Integer]
primeslessthan4 n = repeat2 nextprime3 (<n) [2]

repeat2 :: ([Integer] -> Integer) -> (Integer -> Bool) -> [Integer] -> [Integer]
repeat2 function condition list | condition (function list) = repeat2 function condition ((function list) : list )
                                | otherwise = list 

newselect :: [(Char,Char)] -> Int -> (Char,Char)
newselect ((a,b): [(c,d)])  0 = (a, b)
newselect ((a,b): [(c,d)]) i = newselect [(c,d)] (i-1)


subtract2 :: Float -> Float -> Float
subtract2 a b = a-b



listdigits :: String -> String
listdigits a | length  a<2 =  a
             | otherwise = head  a : listdigits (tail  a)


recipFacts :: [Double] -- Infinite list of reciprocal factorials, starting from 1/0!
recipFacts = go 1
 where go k = 1 : map (/k) (go (k+1))

e :: Double
e = sum $ takeWhile (>0) recipFacts


data Function x a =       Is a
                        | Only x
                        | Plus x a
                        | Times x a
                        | Exp x a -- a^x
                        | Pow x a -- x^a
                        | Sin x
                        | Cos x
                        | Log x a -- logarithm in base a of x
                        | Apply (Function x a) (Function x a) -- apply the first function to the result of the second one
                        | Inverse (Function x a)

