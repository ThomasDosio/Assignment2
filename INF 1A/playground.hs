import Prelude ()
import Data.List ()
import Data.Char ( isDigit )

isPrime :: Integer -> Bool
isPrime n
  | n <= 1    = False
  | n == 2    = True
  | even n    = False
  | otherwise = all (\d -> n `mod` d /= 0) [3,5..floor (sqrt (fromIntegral n))]

mersenne :: Integer -> Integer
mersenne n = 2^(n) - 1

fibs :: [Integer]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

primeFactorsOf :: Integer -> [Integer]
primeFactorsOf n
  | n < 2 = []
  | n == 2 = [2]
  | otherwise = d : primeFactorsOf (n `div` d)
  where d = head [ i | i <- [2..n], n `mod` i == 0 ]

nextPrime :: Integer -> Integer
nextPrime n = head [ p | p <- [n+1..], isPrime p]

primesUnder :: Integer -> [Integer]
primesUnder n 
  | n < 2 = []
  | otherwise = [ p | p <- [2..n], isPrime p]

primes :: [[Integer]]
primes = map primesUnder [1..]

maxPrimePowers :: Integer -> [Integer]
maxPrimePowers n
  | n < 2 = []
  | otherwise = [ intLog p n | p <- primesUnder n ]

smallestMult :: Integer -> Integer
smallestMult n = product [ (primesUnder n !! i) ^ (maxPrimePowers n !! i) |
  i <- [0.. length (primesUnder n) - 1 ] ]

intLog :: Integer -> Integer -> Integer
intLog b n
  | b > n = 0
  | b == n = 1
  | otherwise = 1 + intLog b (n `div` b)

isPalindrome :: Integer -> Bool
isPalindrome n
  | n < 10 = True
  | otherwise = and [ (w !! i) == (w !! (length w - i - 1) ) | i <- [0..(length w - 1) `div` 2] ]
  where w = show n

get :: [a] -> [Int] -> [a]
get arr inds 
  | length inds == 0 = []
  | otherwise = (arr !! (head inds)) : get arr (tail inds)

to :: Integer -> [Integer]
to n = [1..n]

strToDig :: String -> [Integer]
strToDig s = map (read . (:[])) (filter isDigit s)

maxProductWindow :: Int -> [Integer] -> Integer
maxProductWindow dig arr = maximum [ product (get arr [i.. i+dig-1]) | i <- [0.. (length arr) - dig]]

leg1 :: Integer -> Integer -> Integer
leg1 x y = abs (x^2 - y^2)

leg2 :: Integer -> Integer -> Integer
leg2 x y = 2 * x * y

hyp :: Integer -> Integer -> Integer
hyp x y = x^2 + y^2

tri :: Integer -> Integer -> [Integer]
tri x y = map (\f -> f x y) [leg1, leg2, hyp]



---------------------- Project Euler
q1 :: Integer
q1 = sum [3,6..999] + sum [5,10..999] - sum[15,30..999]

q2 :: Integer
q2 = sum [ f | f <- (takeWhile (< 4 * 10^6) fibs), even f]

q3 :: Integer
q3 = maximum $ primeFactorsOf 600851475143

q4 :: Integer
q4 = maximum [ i * j | (i,j) <- range((100,100),(999,999)), isPalindrome (i*j) ]

q5 :: Integer
q5 = smallestMult 20

q6 :: Integer
q6 = abs $ sum (map (\x -> x^2) (to 100)) - sum (to 100)^2

q7 :: Integer
q7 = iterate nextPrime 0 !! 10001

q8 :: Integer
q8 = 0 -- Sorry not sorry but this poor text editor can't handle me pasting in a 1000 digit number. 
       -- I'd have to paste it as a string, break it up with newlines (\n), concatenate it, then
       -- and only then could I pass it forward as an integer. 

q9 :: Integer
q9 = product $ head [ tri x (25-x) | x <- to 25, x > 12, sum ( tri x (25-x) ) == 1000 ]

q10 :: Integer
q10 = sum $ primesUnder (2 * 10^6)