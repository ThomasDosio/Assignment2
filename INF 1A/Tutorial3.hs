import Data.List ( isInfixOf, transpose )
import Test.QuickCheck ()
import Data.Char (Char,isUpper,isAlpha, toUpper)

import Test.QuickCheck
main :: IO ()
main = return ()
-- These are some helper functions for makeKey and makeKey itself.
-- Exercises continue below.

rotate :: Int -> [Char] -> [Char]
rotate k list | 0 <= k && k <= length list = drop k list ++ take k list
              | otherwise = error "Argument to rotate too large or too small"

--  prop_rotate rotates a list of lenght l first an arbitrary number m times,
--  and then rotates it l-m times; together (m + l - m = l) it rotates it all
--  the way round, back to the original list
--
--  to avoid errors with 'rotate', m should be between 0 and l; to get m
--  from a random number k we use k `mod` l (but then l can't be 0,
--  since you can't divide by 0)

prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
                        where l = length str
                              m = if l == 0 then 0 else k `mod` l

alphabet = ['A'..'Z']
makeKey :: Int -> [(Char, Char)]
makeKey k = zip alphabet (rotate k alphabet)

-- ** Caesar Cipher Exercises

-- 1.
lookUphelper :: Char -> [(Char, Char)] -> [Char]
lookUphelper letter pairs | elem letter ([firstcharacter pair | pair <- pairs]) = [secondcharacter pair | pair <- pairs, firstcharacter pair == letter]
                          | otherwise = [letter]

lookUp :: Char -> [(Char, Char)] -> Char
lookUp letter []  = letter
lookUp letter pairs= head (lookUphelper letter pairs)


head2 :: [(Char, Char)] -> (Char, Char)
head2 (head:tail) = head

tail2 :: [(Char, Char)] -> [(Char, Char)]
tail2 (head:tail) = tail


secondcharacter :: (Char, Char) -> Char
secondcharacter (b,c) = c

firstcharacter :: (Char, Char) -> Char
firstcharacter (b,c) = b

lookUpHelperRec :: Char -> [(Char, Char)] -> Char
lookUpHelperRec letter pairs 
      | firstcharacter (head2(pairs)) == letter && (elem letter [firstcharacter pair | pair <- pairs ] || elem letter [secondcharacter pair | pair <- pairs] )= secondcharacter (head2(pairs))
      | firstcharacter (head2(pairs)) /= letter && (elem letter [firstcharacter pair | pair <- pairs ] || elem letter [secondcharacter pair | pair <- pairs] ) = lookUpHelperRec letter (tail(pairs))
      | otherwise = letter

lookUpRec :: Char -> [(Char, Char)] -> Char
lookUpRec letter []  = letter
lookUpRec letter pairs = lookUpHelperRec letter pairs 

prop_lookUp :: Char -> [(Char, Char)] -> Bool
prop_lookUp letter pairs = lookUp letter pairs == lookUpRec letter pairs



-- 2.
encipher :: Int -> Char -> Char
encipher number letter = lookUp letter (makeKey number)

-- 3.
normalise :: String -> String
normalise str = [toUpper x | x <- str, isAlpha x]

normaliseRec :: String -> String
normaliseRec str 
      | null str = []
      | not(isAlpha (head str)) = normalise (tail str)
      | toUpper (head str) == head str = head str : normaliseRec (tail str)
      | toUpper (head str) /= head str = toUpper (head str) : normaliseRec (tail str)



prop_normalise :: String -> Bool
prop_normalise str = normalise str == normaliseRec str

-- 4.
enciphers :: Int -> String -> String
enciphers number str= [encipher number x | x <- normalise str]

-- 5.
reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey str = [reverse2 xs | xs<- str]

reverse2 :: (Char,Char) -> (Char, Char)
reverse2 (a,b) = (b,a)

reverseKeyRec :: [(Char, Char)] -> [(Char, Char)]
reverseKeyRec [] = []
reverseKeyRec str = reverse2 (head str) : reverseKeyRec (tail str)

prop_reverseKey :: [(Char, Char)] -> Bool
prop_reverseKey str = reverseKey str == reverseKeyRec str

-- 6.
decipher :: Int -> Char -> Char
decipher number letter= lookUp2 letter (makeKey number)

lookUphelper2 :: Char -> [(Char, Char)] -> [Char]
lookUphelper2 letter pairs | elem letter ([firstcharacter pair | pair <- pairs]) = [firstcharacter pair | pair <- pairs, secondcharacter pair == letter]
                           | otherwise = error "not capital letter or not included in list of letters"

lookUp2 :: Char -> [(Char, Char)] -> Char
lookUp2 letter []  = letter
lookUp2 letter pairs= head (lookUphelper2 letter pairs)

decipherStr :: Int -> String -> String
decipherStr number str= [decipher number xs | xs <- str, elem xs alphabet]

r = ["123","abc","ABC"]

-- ** Optional Material

-- 7.
candidates :: String -> [(Int, String)]
candidates str = [xs| xs <- helpercandidates str, isInfixOf "THE" (secondcharacter2(xs))||isInfixOf "AND" (secondcharacter2(xs))]

helpercandidates :: String -> [(Int,String)]
helpercandidates str = zip [1..26] [(decipherStr x str ) | x <- [1..26]]

secondcharacter2 :: (Int,String)-> String
secondcharacter2 (b,c) = c

splitEachFive :: String -> [String]
splitEachFive xs | length xs > 5 = take 5 xs : splitEachFive (drop 5 xs)
                 | otherwise     = [ fillToFive xs ]

fillToFive :: String -> String
fillToFive xs = xs ++ replicate (5 - length xs) 'X'

-- An alternative solution demonstrating 'repeat'
fillToFive' :: String -> String
fillToFive' xs = take 5 (xs ++ repeat 'X')

-- The following example shows why 'transpose' is not
--  invertible in general. The transpose function
--  takes the 'columns' of a list of lists, and makes
--  them the 'rows' of a new list of lists. 
--
-- [[o n e],           [[o t t f f],       [[o n e e e],
--  [t w o],            [n w h o i],        [t w o r],  
--  [t h r e e],   -->  [e o r u v],   -->  [t h r e],  
--  [f o u r],          [e r e],            [f o u], 
--  [f i v e]   ]       [e],        ]       [f i v]     ]   

-- 8.
encrypt :: Int -> String -> String
encrypt number sentence = joinlotsofstrings (transpose ( splitEachFive (enciphers number sentence)))

joinstrings :: String -> String -> String
joinstrings str1 str2 = str1++str2

joinlotsofstrings :: [String] -> String
joinlotsofstrings [] = []
joinlotsofstrings strs = joinstrings (firstcharacter2 strs) (joinlotsofstrings (tail strs))

firstcharacter2 :: [String] -> String
firstcharacter2 (head:tail) = head



-- 9.
decrypt :: Int -> String -> String
decrypt number str = decipherStr number (joinlotsofstrings (transpose (splitstring str ((division (length str) 5)))))

splitstring :: String ->Int -> [String]
splitstring [] number= []
splitstring str number
      | length str > 0 = take number str : splitstring (drop number str) number
      | otherwise = []

division :: Int -> Int -> Int
division a b | mod a b == 0 && a==0 = 0
             | mod a b == 0 && a==5 = 1
             | mod a b == 0 && a==10 = 2
             | mod a b == 0 && a==15 = 3
             | mod a b == 0 && a==20 = 4
             | mod a b == 0 && a==25 = 5
             | mod a b == 0 && a==30 = 6
             | mod a b /= 0 && a<=5 = 1
             | mod a b /= 0 && a<=10 && a <5= 2
             | mod a b /= 0 && a<=15 && a <10= 3
             | mod a b /= 0 && a<=20 && a <15= 4
             | mod a b /= 0 && a<=25 && a <20= 5
             | mod a b /= 0 && a<=25 && a <30= 6
             |otherwise = 1


c :: String
c = "QVNXNHRVUWBJUJCBXVQX"



prop_a xs = maximum xs == foldr `max` 0 xs


q = [-3,-5,6,-8,2]

h xs  =  product [ x*x*x | x <- xs, x < 0 ]