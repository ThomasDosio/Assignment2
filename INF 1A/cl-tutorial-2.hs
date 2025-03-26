---Exercise 1 : They all could be considered the odd one out for one reason or another. A is the only object that shares all their properties with other objects in the group and so could be considered the odd one out for that reason. B is the only shape without a bold border. C is the only element that isn't a square. D is the only element that isn't orange. E is the only element that is smaller than the others. It really depends on what you consider to be most important


data Thing = A | B | C | D | E deriving (Eq, Show)
things :: [Thing]
things = [A,B,C,D,E]
type Predicate u = u -> Bool

data Border = Bold | Thin deriving (Eq,Show)
data Shape = Square | Circle deriving (Eq,Show)
data Colour = Orange | Blue deriving (Eq,Show)
data Size = Big | Small deriving (Eq,Show)

border :: Thing -> Border
border x = if x /= B then Bold else Thin

shape :: Thing -> Shape
shape x = if x /= C then Square else Circle

colour :: Thing -> Colour
colour x = if x /= D then Orange else Blue

size :: Thing -> Size
size x = if x /= E then Big else Small

isBold :: Predicate Thing
isBold x = x /= B

isThin :: Predicate Thing
isThin x = x == B

isSquare :: Predicate Thing
isSquare x = x /= C

isCircle :: Predicate Thing
isCircle x = x == C

isOrange :: Predicate Thing
isOrange x = x /= D

isBlue :: Predicate Thing
isBlue x = x == D

isBig :: Predicate Thing
isBig x = x /= E

isSmall :: Predicate Thing
isSmall x = x == E

--everybluesquarehasathinborder :: Bool
--everybluesquarehasathinborder = and [isThin x | x<- things, isBlue x && isSquare x]
--false

--someambercircleisnotbig :: Bool
--someambercircleisnotbig = or [isSmall x | x <- things, isOrange x && isCircle x]
--false

--no square is blue is the same as writing that there doesn't exist a square thing such that the thing is blue or, alternatively, every square thing is not blue (meaning it is orange)
method1 :: Bool
method1 = or [isBlue x | x <- things, isSquare x] == False

method2 :: Bool
method2 = and [isOrange x | x <- things, isSquare x]

thingsOtherThan :: Thing -> [Thing]
thingsOtherThan x = [a | a <- things, a /= x]

properties :: [Predicate Thing]
properties = [isBold, isThin, isSquare, isCircle, isOrange, isBlue, isBig, isSmall]

propertiesOf :: Thing -> [Predicate Thing]
propertiesOf x = [a | a <- properties, a x == True]

isPropertyOfAnotherThing :: Predicate Thing -> Thing -> Bool
isPropertyOfAnotherThing a x = or [a b | b <- things, b/= x]

propertiesOnlyOf :: Thing -> [Predicate Thing]
propertiesOnlyOf x = [a | a <- properties, isPropertyOfAnotherThing a x == False]

rank :: Thing -> Int
rank x = length (propertiesOnlyOf x)

-- The rank of A stands out because it is the only one that doesn't have a unique property