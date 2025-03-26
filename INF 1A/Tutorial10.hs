module Tutorial10 where

import Test.QuickCheck
import Control.Monad
import Data.Char

-- Question 1

-- 1a

ok :: String -> Bool
ok str = map toLower str == str && length str <6 && and (map isAlpha str)

-- 1b

f :: [String] -> String
f strs | [x | x <- strs, ok x] == [] = "zzzzz"
       | [x | x <- strs, ok x] /= [] = minimum [w | w <- [x | x <- strs, ok x]]

-- 1c

g :: [String] -> String
g [] = "zzzzz"
g (x:xs) | all ok (x:xs) && x == minimum (x:xs) = x
         | all ok (x:xs) && x /= minimum (x:xs) = g xs
         | any ok (x:xs) && ok x = g (x: isok xs)
         | any ok (x:xs) && not (ok x) = g (isok xs)
         | otherwise = "zzzzz"
           where isok [] = []
                 isok (e:es) | ok e = e : isok es
                             | otherwise = isok es

-- 1d

h :: [String] -> String
h [] = "zzzzz"
h strs | (filter ok strs) /= [] =  minimum (filter ok strs)
       | otherwise = "zzzzz"

-- Question 2

-- 2a

i :: [a] -> [a] -> [a]
i str1 str2 = tail str1 ++ [head str2]
-- 2b

j :: [[a]] -> [[a]]
j strs = 

-- 2c

k :: [[a]] -> [[a]]
k = undefined

-- Question 3

data Prop = X
          | Y
          | T
          | F
          | Not Prop
          | Prop :&&: Prop
          | Prop :||: Prop
          | Prop :->: Prop
  deriving (Eq, Show)

instance Arbitrary Prop where
  arbitrary = sized gen
    where
    gen 0 =
      oneof [ return X,
              return Y,
              return T,
              return F ]
    gen n | n>0 =
      oneof [ return X,
              return Y,
              return T,
              return F,
              liftM Not prop,
              liftM2 (:&&:) prop prop,
              liftM2 (:||:) prop prop,
              liftM2 (:->:) prop prop]
      where
      prop = gen (n `div` 2)

-- 3a

eval :: Bool -> Bool -> Prop -> Bool
eval = undefined

-- 3b

simple :: Prop -> Bool
simple = undefined

-- 3c

simplify :: Prop -> Prop
simplify = undefined
