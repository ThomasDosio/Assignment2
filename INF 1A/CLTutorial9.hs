-- Informatics 1 - Introduction to Computation
-- Computation and Logic Tutorial 9
--
-- Remember: there are many possible solutions, and if your solution produces
-- the right results, then it is (most likely) correct. However, our solutions
-- require only a few of lines for each answer. If your code is getting complicated
-- you're making things too difficult for yourself---try to keep it simple!

module CLTutorial9 where
import Prelude hiding (lookup)
import Data.Set(Set, insert, empty, member, fromList, toList,
                 union,intersection, size, singleton, (\\))
import qualified Data.Set as S
import Test.QuickCheck
import Data.Char

-- EXERCISE 2 - give your answer to exercise 2 here.
-- The following list contains the five strings in the question.
-- REMOVE the strings that are not accepted by the automaton.

ex2strings = [ "abbd", "ad", "abbbc", "ac" ]


-- you should also familiarise yourself with
-- the functions from Data.Set imported above
-- we define infix version of union and intersection
(\/) :: Ord a => Set a -> Set a -> Set a
(\/)  = union
(/\) :: Ord a => Set a -> Set a -> Set a
(/\) = intersection

-- Data.Set provides functions like map and filter that work for sets instead of 
-- lists: we give the names mapS and filterS to the Set versions of map and filter
mapS :: (Ord a, Ord b) => (a -> b) -> Set a -> Set b
mapS = S.map
filterS :: Ord a => (a -> Bool) ->  Set a -> Set a
filterS = S.filter

-- Type declarations

type Sym = Char
type Trans q = (q, Sym, q)
--  FSM states symbols transitions starting accepting 
--                   Q      Sigma        delta       S        F
data FSM q = FSM (Set q) (Set Sym) (Set(Trans q)) (Set q) (Set q) deriving Show
mkFSM :: Ord q => [q] -> [Sym] -> [Trans q] -> [q] -> [q] -> FSM q 
mkFSM qs as ts ss fs =  -- a convenience function constructing FSM from lists
  FSM (fromList qs) (fromList as) (fromList ts) (fromList ss) (fromList fs)

-- eg 1
eg1 = mkFSM [0..3] "abcd"
  ([(0,'a',1)]++(map (\x->(0,x,3)) "bcd")
    ++[(1,'b',1),(1,'c',2),(1,'d',2),(1,'a',3)]
    ++(map (\x->(2,x,3)) "abcd")
    ++(map (\x->(3,x,3)) "abcd"))
  [0] [2]

-- Ex 3.
-- DFA -- 
isDFA :: Ord q => FSM q -> Bool
isDFA (FSM qs as ts ss fs) = (size ss == 1)
  && and [ length[ q' | q' <- toList qs, (q, a, q')`member`ts ] == 1
               | q <- toList qs, a <- toList as ]
  
-- applying transitions for a given symbol to move a list of states
transition :: (Ord q) => Set(Trans q)  -> Set q -> Sym -> Set q
transition ts qs s  = fromList [ q' | (q, t, q') <- toList ts, t == s, q `member` qs ]

-- applying transitions for a string of symbols
-- final ::  Ord q => Set(Trans q) ->Set q -> [Sym] -> Set q
-- final ts ss [] = ss
-- final ts ss (a : as) = final ts (transition ts ss a) as
-- final ts = foldl (transition ts)
 
accepts :: (Ord q) => FSM q -> [Sym] -> Bool 
accepts (FSM _ _ ts ss fs)  string = (not.null) (fs /\ final)
  where final = foldl (transition ts) ss string

-- Ex 4
trace :: Ord q => FSM q -> [Sym] -> [Set q]
trace (FSM qs as ts ss fs) word = tr ss word  where 
  tr ss' [] = [ss']
  tr ss' (w : ws) =ss' : tr (transition ts ss' w) ws

-- Example machines

m1 :: FSM Int
m1 = mkFSM
     [0,1,2,3,4] -- states
     "ab"        -- symbols
     [ (0,'a',1), (0,'b',1), (0,'a',2), (0,'b',2), (1,'b',4)
     , (2,'a',3), (2,'b',3), (3,'b',4), (4,'a',4), (4,'b',4) ]
     [0]  -- starting
     [4]  -- accepting

m2 :: FSM Char
m2 = mkFSM
     "ABCD"      -- states
     "01"        -- symbols
     [('A', '0', 'D'), ('A', '1', 'B'), ('B', '0', 'A'), ('B', '1', 'C'),
      ('C', '0', 'B'), ('C', '1', 'D'), ('D', '0', 'D'), ('D', '1', 'D')]
     "B"   -- starting
     "ABC" -- accepting

dm1 :: FSM [Int] 
dm1 = mkFSM 
      [[],[0],[1,2],[3],[3,4],[4]] -- states
      "ab"                         -- symbols
      [([],   'a',[]),    ([],   'b',[])
      ,([0],  'a',[1,2]), ([0],  'b',[1,2])
      ,([1,2],'a',[3]),   ([1,2],'b',[3,4])
      ,([3],  'a',[]),    ([3],  'b',[4])
      ,([3,4],'a',[4]),   ([3,4],'b',[4])
      ,([4],  'a',[4]),   ([4],  'b',[4])]
      [[0]]       -- starting
      [[3,4],[4]] -- accepting


-- EXERCISE 5
{- Optional - if you wish, you may write an answer for exercise 5 here.

If we set an alphabet S and the set of regular languages L we can show that the set of regular languages is a boolean algebra with regards to union, intersection and complement because it fulfils all of the axioms of boolean algebra. 
Associativity holds because the union of two languages and a third is the same as the union of all three and thats the same as the union of the first and the union of the other two. The same works for the intersection
If we take the union of two languages then thats is independent of the order in which they appear so commutativity also holds.
If we take the union of one language and its intersection with another language then that means that we can just use the first language because the intersection of a set is contained within the set itself and so the union of the first language with a part of itself will just return the first language.
If we set the identity language to be the language that accepts any combination and order of symbols from S and the zero language to be the one that accepts no combination in any order of symbols then the identity axioms hold because the union of a language and the zero language is just the language because no other strings of symbils are accepted and because if we take the intersection of a language and the langauge that accepts any string we justget the langauge back.
Distributivity also holds because for both union distributing intersection and vice versa, langauges behave like any other set and take the elements that are in common for intersection and all elements of both for union.
The complement of a language is the set that contains all the combinations of elements of S in any order excpet those in the language, so the union of a language and its complement is just S whereas thee are no strings that are both part of the langauge and not part of the language and so the intersection is the zero language.
Therefore it is a boolena algebra.

The cartesian product is not commutative and so cannot be used as an operator for a boolean algebra.

I don't know. 

-} 
