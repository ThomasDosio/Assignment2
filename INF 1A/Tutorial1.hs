module Tutorial1 where

import PicturesSVG -- needed for the optional chess part
import Test.QuickCheck



-- 2.
double :: Int -> Int
double x = x + x

square :: Int -> Int
square x = x * x

-- 3.
isTriple :: Int -> Int -> Int -> Bool
isTriple a b c = a * a + b * b == c * c

-- 4.
leg1 :: Int -> Int -> Int
leg1 x y = x * x - y * y

leg2 :: Int -> Int -> Int
leg2 x y = 2 * x * y

hyp :: Int -> Int -> Int
hyp x y = x * x + y * y

-- 5.
prop_triple :: Int -> Int -> Bool
prop_triple x y = isTriple (leg1 x y) (leg2 x y) (hyp x y)

-- 8.
pic1 :: Picture
pic1 = above (beside knight (invert knight)) (beside (invert knight) knight)


pic2 :: Picture
pic2 = above (beside knight (invert knight)) (beside (flipV (invert knight)) (flipV knight))

-- ** Functions

twoBeside :: Picture -> Picture
twoBeside x = beside x (invert x)

-- 9.
twoAbove :: Picture -> Picture
twoAbove x = above x (invert x)

fourPictures :: Picture -> Picture
fourPictures x = twoAbove (twoBeside x)

-- 10.
-- a)
emptyRow :: Picture
emptyRow = repeatH 4 (beside whiteSquare blackSquare)

-- b)
otherEmptyRow :: Picture
otherEmptyRow = repeatH 4 (beside blackSquare whiteSquare)
-- c)
middleBoard :: Picture
middleBoard = repeatV 2 (above emptyRow otherEmptyRow)

-- d)
whiteRow :: Picture
whiteRow = beside (beside (beside (over  rook blackSquare) (over knight whiteSquare)) (beside (over  bishop blackSquare) (over queen whiteSquare))) (beside (beside (over king blackSquare) (over bishop whiteSquare)) (beside (over knight blackSquare) (over rook whiteSquare)))

blackRow :: Picture
blackRow = beside (beside (beside (over  (invert rook) whiteSquare) (over (invert knight) blackSquare)) (beside (over  (invert bishop) whiteSquare) (over (invert queen) blackSquare))) (beside (beside (over (invert king) whiteSquare) (over (invert bishop) blackSquare)) (beside (over (invert knight) whiteSquare) (over (invert rook) blackSquare)))

-- e)

blackPawns :: Picture
blackPawns = repeatH 4 (beside (over (invert pawn) blackSquare) (over (invert pawn) whiteSquare))

whitePawns :: Picture
whitePawns = repeatH 4 (beside (over pawn whiteSquare) (over pawn blackSquare))

populatedBoard :: Picture
populatedBoard = above (above (above blackRow blackPawns) middleBoard) (above whitePawns whiteRow)

findtriple :: Integer -> [Integer]
findtriple x = [(a,b,c) | (a,b,c)<- [1..1000], a+b+c == x,  isTriple (a,b,c)]