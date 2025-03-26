module Tutorial4 where

import Data.Char
import Data.List
import Test.QuickCheck
import Data.Ratio
import GHC.Base (VecElem(Int16ElemRep))


-- 1. doubles
-- a.
doublesComp :: [Int] -> [Int]
doublesComp list = [2*a | a <- list]

-- b.
doublesRec :: [Int] -> [Int]
doublesRec [] = []
doublesRec (x:xs) = 2*x : doublesRec xs

-- c.
doublesHO :: [Int] -> [Int]
doublesHO [] = []
doublesHO list = map sqr list
    where sqr:: Int -> Int
          sqr x = 2 *x

-- d.
prop_doubles :: [Int] -> Bool
prop_doubles list =  (doublesComp list == doublesRec list) && (doublesRec list == doublesHO list) && (doublesComp list == doublesHO list)

-- 2. aboves
-- a.
abovesComp :: Int -> [Int] -> [Int]
abovesComp x list = [a | a <- list, a > x]

-- b.
abovesRec :: Int -> [Int] -> [Int]
abovesRec x [] = []
abovesRec x (head:tail) | head > x = head : abovesRec x tail
                        | otherwise = abovesRec x tail

-- c.
abovesHO :: Int -> [Int] -> [Int]
abovesHO x list = filter p list
    where p :: Int -> Bool
          p a = a > x

s :: [Int]
s = [1,2,3,4,5,6,7,8,9,13,3456,345654]

-- d.
prop_aboves :: Int -> [Int] -> Bool
prop_aboves x list =  (abovesComp x list == abovesRec x list) && (abovesRec x list == abovesHO x list) && (abovesComp x list == abovesHO x list)

-- 3. parity
-- a.
xor :: Bool -> Bool -> Bool
xor a b | a && b = False
        | not (a) && not (b) = False
        | otherwise = True

-- b.
parityRec :: [Bool] -> Bool
parityRec [] = True
parityRec (x:xs) = xor x (parityRec xs)

-- c.
parityHO :: [Bool] -> Bool
parityHO [] = True
parityHO (x:xs) = foldr xor True (x:xs)

-- d.
prop_parity :: [Bool] -> Bool
prop_parity list = parityRec list == parityHO list

-- 4. allcaps
-- a.
allcapsComp :: String -> Bool
allcapsComp str = and [isUpper x | x <- str, isAlpha x]

-- b.
allcapsRec :: String -> Bool
allcapsRec [] = True
allcapsRec (x:xs) | isAlpha x = isUpper x && allcapsRec xs
                  | otherwise = allcapsRec xs

-- c.
allcapsHO :: String -> Bool
allcapsHO [] = True
allcapsHO str = foldr (&&) True (map isUpper (filter isAlpha str))
 
-- d.
prop_allcaps :: String -> Bool
prop_allcaps str = (allcapsComp str == allcapsRec str) && (allcapsRec str == allcapsHO str) && (allcapsComp str == allcapsHO str)


-- ** Optional material
-- Matrix manipulation

type Matrix = [[Rational]]

-- 5
-- a.
uniform :: [Int] -> Bool
uniform [] = True
uniform (x:xs) = all (== x ) xs

t:: [Int]
t = [1,1,1,1,1,1,1,0]

all2 :: (a -> Bool) -> [a] -> Bool
all2 f [] = True
all2 f str = foldr (&&) True (map f str)


valid :: Matrix -> Bool
valid matrix = uniform (map length matrix) && not (all null matrix)

q :: [[Rational]]
q= [[1,2], [4,5,8]]

w :: [[Rational]]
w = [[7,8], [9,10]]

-- 6.
width :: Matrix -> Int
width m | valid m = length (head m)
        | otherwise = error "matrix is not valid"

height :: Matrix -> Int
height m | valid m = length m
         | otherwise = error "matrix is not valid" 

plusM :: Matrix -> Matrix -> Matrix
plusM a b | height a /= height b = error "matrices have different heights"
          | width a /= width b = error "matrices have different widths"
          | otherwise =  zipWith plusRow a b 
                where plusRow :: [Rational] -> [Rational]-> [Rational]
                      plusRow = zipWith (+)

-- 7.
timesM :: Matrix -> Matrix -> Matrix
timesM a b | width a /= height b = error "matrices are not of compatible sizes"
           | otherwise = [map (dot x) (transpose b) | x <- a]
                where dot :: [Rational] -> [Rational] -> Rational
                      dot c v= sum (zipWith (*) c v)



-- ** Challenge

-- 8.
-- Mapping functions
mapMatrix :: (a -> b) -> [[a]] -> [[b]]
mapMatrix f = undefined

zipMatrix :: (a -> b -> c) -> [[a]] -> [[b]] -> [[c]]
zipMatrix f = undefined

-- All ways of deleting a single element from a list
removes :: [a] -> [[a]]     
removes = undefined

-- Produce a matrix of minors from a given matrix
minors :: Matrix -> [[Matrix]]
minors m = undefined

-- A matrix where element a_ij = (-1)^(i + j)
signMatrix :: Int -> Int -> Matrix
signMatrix w h = undefined
        
determinant :: Matrix -> Rational
determinant = undefined

cofactors :: Matrix -> Matrix
cofactors m = undefined        
                
scaleMatrix :: Rational -> Matrix -> Matrix
scaleMatrix k = undefined

inverse :: Matrix -> Matrix
inverse m = undefined

-- Tests
identity :: Int -> Matrix
identity n = undefined

prop_inverse1 :: Rational -> Property
prop_inverse1 a = undefined

prop_inverse2 :: Rational -> Rational -> Rational 
                -> Rational -> Property
prop_inverse2 a b c d = undefined

type Triple a = (a,a,a)
        
prop_inverse3 :: Triple Rational -> 
                 Triple Rational -> 
                 Triple Rational ->
                 Property
prop_inverse3 r1 r2 r3 = undefined


doublesHO2 :: [Int] -> [Int]
doublesHO2 [] = []
doublesHO2 list = map (2*) list

timesM2 :: Matrix -> Matrix -> Matrix
timesM2 a b | width a /= height b = error "matrices are not of compatible sizes"
           | otherwise = [map ((\c v -> sum (zipWith (*) c v)) x) (transpose b) | x <- a]


all3 :: (a -> Bool) -> [a] -> Bool
all3 f [] = True
all3 f str = foldr ((&&).f) True str



