
import Data.Char
import Data.List
import Test.QuickCheck


-- 1. inRange

inRange :: Int -> Int -> [Int] -> [Int]
inRange lo hi xs = [x | x <- xs, x>= lo, x<= hi]


-- 2. multDigits

multDigits :: String -> Int
multDigits str = product [digitToInt x | x <-  str, isDigit x]

countDigits :: String -> Int
countDigits str = length[x | x <- str, isDigit x]

prop_multDigits :: String -> Bool
prop_multDigits str = multDigits str <= 9 ^ countDigits str


-- 3. capitalise and title

allsmall :: String -> String
allsmall str = [toLower x | x <- str]

capitalise :: String -> String
capitalise (x:xs) = toUpper x : allsmall xs

title :: [String] -> [String]
title (head:tail) = [capitalise xs | xs <- head:tail, xs==head || length xs >= 4]

eds :: [String]
eds = ["TT", "HELLO", "THHE",  "HGVBNJUYGjhbnjh"]

-- 4. score and totalScore

letters :: [Char]
letters = "bcdfghjklmnpqrstvwxyz"

capletters :: [Char]
capletters = "BCDFGHJKLMNPQRSTVWXYZ"

vowels :: [Char]
vowels = "aeiou"

capvowels :: [Char]
capvowels = "AEIOU"

score :: Char -> Int
score n 
  |toLower n == n && n `elem` letters = 1
  |(toUpper n == n && n `elem` capletters) || n `elem` vowels= 2
  |toUpper n == n && (n `elem` capvowels)= 3
  |otherwise = 0

totalScore :: String -> Int
totalScore xs = product [score x | x<- xs, x `elem` letters || x `elem` capletters ||x `elem` vowels || x `elem` capvowels ]

prop_totalScore_pos :: String -> Bool
prop_totalScore_pos xs = totalScore xs >= 1



-- ** Optional Material

-- 5. crosswordFind

crosswordFind :: Char -> Int -> Int -> [String] -> [String]
crosswordFind letter pos len words = [xs | xs <- words, length xs == len,  letterpos letter pos xs]

letterpos :: Char -> Int -> String -> Bool
letterpos letter pos word= word !! pos == letter


-- 6. search

search :: String -> Char -> [Int]
search str goal =[first x | x <- (positionnumber (letterpos2 goal (length str) str)), True `elem` x ] 

first :: (Int,Bool) -> Int
first (a,b) = a

letterpos2 :: Char -> Int -> String -> [Bool]
letterpos2 letter a word = [word !! x == letter |  x  <- [0..(a-1)]]

positionnumber :: [Bool] -> [(Int,Bool)]
positionnumber xs= zip [0..] (xs)



-- Depending on the property you want to test, you might want to change the type signature
prop_search :: String -> Char -> Bool
prop_search str goal = length (search str goal) <= length str

