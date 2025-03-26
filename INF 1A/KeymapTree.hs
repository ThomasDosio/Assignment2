module KeymapTree ( Keymap,
                    invariant, keys,
                    size, depth, get, set, select,
                    toList, fromList,
                    filterLT, filterGT, merge,
                    -- for testing
                    prop_set_get, prop_toList_fromList,
                    testTree, prop_merge
                  )
where

-- Modules for testing
  
import Test.QuickCheck
import Control.Monad
import Data.List
  
-- The data type

data Keymap k a = Leaf
                | Node k a (Keymap k a) (Keymap k a)
                deriving (Eq, Show)

-- A test tree

testTree :: Keymap Int Int
testTree = Node 2 20 (Node 1 10 Leaf Leaf)
                     (Node 3 30 Leaf 
                               (Node 4 40 Leaf Leaf ))

-- Invariant

invariant :: Ord k => Keymap k a -> Bool
invariant Leaf  =  True
invariant (Node k _ left right)  =  all (< k) (keys left) &&
                                    all (> k) (keys right) &&
                                    invariant left &&
                                    invariant right

keys :: Keymap k a -> [k]
keys Leaf  =  []
keys (Node k _ left right)  =  keys left ++ [k] ++ keys right

size :: Keymap k a -> Int
size Leaf = 0
size (Node _ _ left right) = 1 + size left + size right

depth :: Keymap k a -> Int
depth Leaf = 0
depth (Node _ _ left right) = 1 + (depth left `max` depth right)

-- Exercise 3

toList :: Keymap k a -> [(k,a)]
toList Leaf = []
toList (Node k a ls rs) = toList ls ++ [(k,a)] ++ toList rs

-- Exercise 4

set :: Ord k => k -> a -> Keymap k a -> Keymap k a
set key value = go
    where go Leaf = Node key value Leaf Leaf
          go (Node k v left right) | key == k = Node k value left right
                                   | key < k  = Node k v (go left) right
                                   | key > k  = Node k v left (go right)
                                     

-- Exercise 5

get :: Ord k => k -> Keymap k a -> Maybe a
get j Leaf = Nothing
get j (Node l a ls rs) | j==l = Just a
                       | j/=l = choose [get j ls, get j rs]
          where choose:: [Maybe a] -> Maybe a
                choose [] = Nothing   
                choose (x:xs) | isNothing2 x = choose xs
                              | otherwise = x
                        where isNothing2 :: Maybe a -> Bool
                              isNothing2 Nothing = True
                              isNothing2 _ = False


prop_set_get :: Int -> String -> Keymap Int String -> Bool
prop_set_get k v db = get k (set k v db) == Just v

-- Exercise 6

fromList :: Ord k => [(k,a)] -> Keymap k a
fromList = foldr (uncurry set) Leaf

prop_toList_fromList :: [Int] -> [String] -> Bool
prop_toList_fromList xs ys  =  toList (fromList zs) == sort zs
  where zs = zip (nub xs) ys


-- ** Optional Material

-- Exercise 8

filterLT :: Ord k => k -> Keymap k a -> Keymap k a
filterLT k Leaf = Leaf
filterLT j ks = maketree [xs | xs<- keys ks, xs<j]
     where maketree [] = Leaf
           maketree (x:xs) = set x (fix (get x ks)) (maketree xs)
            where fix :: Maybe a -> a
                  fix Nothing = error "nothing there"
                  fix (Just a) = a
                                     

filterGT :: Ord k => k -> Keymap k a -> Keymap k a
filterGT k Leaf = Leaf
filterGT j ks = maketree [xs | xs<- keys ks, xs>j]
     where maketree [] = Leaf
           maketree (x:xs) = set x (fix (get x ks)) (maketree xs)
            where fix :: Maybe a -> a
                  fix Nothing = error "nothing there"
                  fix (Just a) = a
           
-- Exercise 9
                                     
merge :: Ord k => Keymap k a -> Keymap k a -> Keymap k a
merge Leaf Leaf = Leaf
merge Leaf rs = rs
merge ls Leaf = ls
merge (Node l a ls rs) (Node m b lt rt) | l== m = Node l a (merge ls lt) (merge rs rt)
                                        | l < m = Node m b (merge (Node l a ls rs) lt) rt
                                        | l > m = Node l a (merge (Node m b lt rt) ls) rs

                
prop_merge a b = order (toList a ++ toList b) == toList (merge a b)
    where order []= []
          order (x:xs) | not (null xs) && firstelement x < firstelement (head(xs)) = [x] ++ order (xs)
                       | not (null xs) && firstelement x == firstelement (head (xs)) = order(xs)
                       | not (null xs) && firstelement x > firstelement (head (xs)) = [head xs] ++ [x]++ order (tail (xs))
                       | otherwise = [x]
                  where firstelement (a,b) = a


-- Exercise 10

select :: Ord k => (a -> Bool) -> Keymap k a -> Keymap k a
select prop Leaf = Leaf
select prop (Node a b ls rs) | prop b = Node a b (select prop ls) (select prop rs)
                             | otherwise = merge (select prop ls) (select prop rs)

-- Instances for QuickCheck -----------------------------

instance (Ord k, Arbitrary k, Arbitrary a) => Arbitrary (Keymap k a) where
    arbitrary = liftM fromList (liftM2 zip (liftM nub arbitrary) arbitrary)
