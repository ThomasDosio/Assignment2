-- Informatics 1 - Functional Programming 
-- Class Test 2023

module ClassExam where

import Data.Char
import Test.QuickCheck

-- Problem 1

-- a

f :: String -> Int
f str = sum [ord a | a <- str, isAlpha a]

-- b

g :: String -> Int
g [] = 0
g (x:xs) | isAlpha x = ord x + g xs
         | otherwise = g xs

-- c

h :: String -> Int
h str = foldr (+) 0 (map ord (filter isAlpha str))

-- d

prop_fgh :: String -> Bool
prop_fgh str = f str == g str && g str== h str && f str == h str

-- Problem 2

-- a

c :: String -> String -> Bool
c a b | length a < length b && length a >0 = and [a !! x == b !! x | x <- [0,1..length a-1], isAlpha (a !! x), isAlpha (b !! x )]
      | length a >= length b && length b >0 = and [a !! x== b !! x | x <- [0,1..length b-1], isAlpha (a !! x), isAlpha (b !! x ) ] 
      | otherwise = True

-- b

d :: String -> String -> Bool
d [] b = True
d a [] = True
d (x:xs) (y:ys) | isAlpha x && isAlpha y = (x == y) && d xs ys
                | otherwise = d xs ys

-- c

prop_cd :: String -> String -> Bool
prop_cd a b = c a b == d a b 
