module Tutorial9 where

-- Sudoku solver
-- Based on Bird, "Thinking Functionally with Haskell"

import Data.List (sort,nub,(\\),transpose,genericLength)
import Data.String (lines,unlines)
import Test.QuickCheck

-- Representing Sudoku puzzles

type Row a    = [a]
type Matrix a = [Row a]
type Digit    = Char

-- Examples from websudoku.com

easy :: Matrix Digit
easy = ["    345  ",
        "  89   3 ",
        "3    2789",
        "2 4  6815",
        "    4    ",
        "8765  4 2",
        "7523    6",
        " 1   79  ",
        "  942    "]

medium :: Matrix Digit
medium = ["   4 6 9 ",
          "     3  5",
          "45     86",
          "6 2 74  1",
          "    9    ",
          "9  56 7 8",
          "71     64",
          "3  6     ",
          " 6 9 2   "]

hard :: Matrix Digit
hard = ["9 3  42  ",
        "4 65     ",
        "  28     ",
        "     5  4",
        " 67 4 92 ",
        "1  9     ",
        "     87  ",
        "     94 3",
        "  83  6 1"]

evil :: Matrix Digit
evil = [" 23  4 8 ",
        "  1 7  2 ",
        "     1  7",
        "  4  8  5",
        "         ",
        " 8 36    ",
        "8   5  9 ",
        "9     231",
        " 7       "]

-- Another example, from Bird's book

book :: Matrix Digit
book = ["  4  57  ",
        "     94  ",
        "36      8",
        "72  6    ",
        "   4 2   ",
        "    8  93",
        "4      56",
        "  53     ",
        "  61  9  "]

puzzle2 :: Matrix Digit
puzzle2 =["8        ",
          "  36     ",
          " 7  9 2  ",
          " 5   7   ",
          "    457  ",
          "   1   3 ",
          "  1    68",
          "  85   1 ",
          " 9    4  "]

-- Printing Sudoku puzzles

group :: [a] -> [[a]]
group = groupBy 3

groupBy :: Int -> [a] -> [[a]]
groupBy n [] = []
groupBy n xs = take n xs : groupBy n (drop n xs)

intersperse :: a -> [a] -> [a]
intersperse sep []     = [sep]
intersperse sep (y:ys) = sep : y : intersperse sep ys

showRow :: String -> String
showRow = concat . intersperse "|" . group

showGrid :: Matrix Digit -> [String]
showGrid = showCol . map showRow
  where
    showCol = concat . intersperse [bar] . group
    bar     = replicate 13 '-'

put :: Matrix Digit -> IO ()
put = putStrLn . unlines . showGrid

-- 1.
choice :: Digit -> [Digit]
choice ' '= ['1'..'9']
choice a = [a]

choices :: Matrix Digit -> Matrix [Digit]
choices []=[]
choices (x:xs) = [choice a | a <- x] : choices xs

-- 2.
splits :: [a] -> [(a, [a])]
splits xs  =
  [ (xs!!k, take k xs ++ drop (k+1) xs) | k <- [0..n-1] ]
  where
  n = length xs

pruneRow :: Row [Digit] -> Row [Digit]
pruneRow [] = []
pruneRow (x:xs) | length (fixlength x) == 1 = (fixlength x) : map fixlength (filteredby x xs)
                | otherwise = (fixlength x) : map fixlength xs
  where fixlength :: [Digit] -> [Digit]
        fixlength ws | length ws ==1 = ws
                     | otherwise=  foldr remove ws (map head (filter unitlength xs) )
        filteredby x xs = map (remove (head x) ) xs
        remove a as | length as /= 1 = filter (/= a) as
            | length as == 1 = as
        unitlength xs | length xs == 1 = True
              | otherwise = False



-- this code builds on pruneRow to also prune columns and boxes

pruneBy :: (Matrix [Digit] -> Matrix [Digit]) -> Matrix [Digit] -> Matrix [Digit]
pruneBy f = f . map pruneRow . f

rows, cols, boxs :: Matrix a -> Matrix a
rows = id
cols = transpose
boxs = map ungroup . ungroup . map cols . group . map group
  where
    ungroup :: Matrix a -> [a]
    ungroup = concat

prune :: Matrix [Digit] -> Matrix [Digit]
prune = pruneBy boxs . pruneBy cols . pruneBy rows

-- 3.
close :: Eq a => (a -> a) -> a -> a
close f w | f w == w = w
          | f w /= w = close f (f w)

single :: [Digit] -> Bool
single [d] = True
single _   = False

the :: [Digit] -> Digit
the [d] = d

extract :: Matrix [Digit] -> Matrix Digit
extract [] = []
extract mat | all (all single) mat = map (map the) mat


-- 4.
solve :: Matrix Digit -> Matrix Digit
solve matrix = extract (close (prune) (choices matrix))

-- easy and medium problems can be solved this way

-- ** Optional Material

-- 5.
failed :: Matrix [Digit] -> Bool
failed [] = False
failed (x:xs) = or [null s | s <- x] || failed xs

-- 6.
solved :: Matrix [Digit] -> Bool
solved [] = True
solved (x:xs)= and [unitlength s | s <- x] && solved xs
          where unitlength xs | length xs == 1 = True
                              | otherwise = False

-- 7.
shortest :: Matrix [Digit] -> Int
shortest (x:xs) | not (null xs) =lowest (smallest x, shortest xs)
                | otherwise = smallest x
                        where lowest (a,b) | a<=b = a
                                           | a >b = b
                              smallest (x:xs) | (not (null xs)) && length x>= 2 = lowest (length x, smallest xs)
                                              | null xs&& length x>= 2= length x
                                              | null xs && length x<2 = 100
                                              | otherwise = smallest xs

-- 8.
expand :: Matrix [Digit] -> [Matrix [Digit]]
expand matrix = [firstelement (break (issmallrow matrix) matrix)++ [firstelement (break ( lengthis (shortest matrix)) (smallrow matrix)) ++ [[d] ]++ tail(secondelement((break ( lengthis (shortest matrix)) (smallrow matrix))))]++ tail(secondelement(break (issmallrow matrix) matrix)) | d <- smallestelement matrix ]
        where   firstelement (a,b) = a
                secondelement (a,b)= b
                smallrow (x:xs) = head( filter (elem (smallestelement (x:xs)) ) (x:xs)  )
                issmallrow matrix row = row == (smallrow matrix)
                smallestelement (x:xs) | not(null (filter (lengthis (shortest (x:xs)) )x ))= head (filter (lengthis (shortest (x:xs)))x )
                                       | otherwise = smallestelement xs
                lengthis k x  = length x==k



-- 9.
search :: Matrix Digit -> [Matrix Digit]
search matrix | solved (choices matrix) = [extract (choices matrix)]
              | failed (choices matrix)= []
              | otherwise = filter (equalsolve) (map extract (filter (solved) (newsolve matrix)))
                 where  newsolve :: Matrix Digit -> [Matrix [Digit]]
                        newsolve matrix | solved (close (prune) (choices matrix)) = [close (prune) (choices matrix)]
                                        | failed (close (prune) (choices matrix)) = []
                                        | otherwise = concatMap newsolve (map removes (expand (close (prune) (choices matrix)) ))
                        remove :: [Digit] -> Digit
                        remove xs | length xs == 1 = head xs
                                                  | otherwise = ' '
                        removes :: Matrix [Digit ]-> Matrix Digit
                        removes []=[]
                        removes (x:xs) = [remove a | a <- x] : removes xs
                        equalsolve :: Matrix Digit -> Bool
                        equalsolve qs = and [length x == length (nub x)  | x <- qs ] && 
                                        and [length x == length (nub x) | x <- columns qs] && 
                                        and [length x == length (nub x) | x <- squares qs]
                                where   columns qs = [(map head qs), (map second qs), (map third qs), (map fourth qs), (map fifth qs), (map sixth qs), (map seventh qs), (map eighth qs), (map ninth qs)] 
                                        squares qs = map makesquares (split3 qs)
                                        makesquares xs = map (head. split3) xs  ++ map (second . split3) xs ++  map (third . split3) xs
                                        second (a:b:c) = b
                                        third (a:b:c:d) = c
                                        fourth (a:b:c:d:e) = d
                                        fifth (a:b:c:d:e:f) =e
                                        sixth (a:b:c:d:e:f:g) = f
                                        seventh (a:b:c:d:e:f:g:h) = g
                                        eighth (a:b:c:d:e:f:g:h:i) = h
                                        ninth (a:b:c:d:e:f:g:h:i:j) = i
                                        split3 (a:b:c:d:e:f:g:h:i) | length (a:b:c:d:e:f:g:h:i) == 9 = [[a,b,c], [d,e,f], [g,h,(head i)]]



-- display puzzle and then solution(s) found by search

puzzle :: Matrix Digit -> IO ()
puzzle g = put g >> puts (search g) >> putStrLn "***"
     where puts = sequence_ . map put

main :: IO ()
main = puzzle easy >>
       puzzle medium >>
       puzzle hard >>
       puzzle evil


