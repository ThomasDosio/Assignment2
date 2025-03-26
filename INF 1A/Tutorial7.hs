module Tutorial7 where 


import LSystem 
import Test.QuickCheck 

 

pathExample = Go 30 :#: Turn 120 :#: Go 30 :#: Turn 120 :#: Go 30 

 

-- 1a. copy 

copy :: Int -> Command -> Command 
copy numberofcopies command | numberofcopies < 0 = error "Negative number of copies" 
                            | numberofcopies == 0 = Sit 
                            | numberofcopies > 0 = command :#: copy (numberofcopies-1) command 

 

-- 1b. polygon 

polygon :: Distance -> Int -> Command 
polygon lengthside numberofsides = copy numberofsides ( Go lengthside :#: Turn (360 / fromIntegral numberofsides)) 


-- 2. snowflake 

snowflake :: Int -> Command 
snowflake x =copy 3 ( f x:#: q:#: q ) 
    where f 0 = Go 10 
          f x = f (x-1) :#: r :#: f (x-1) :#: q :#: q :#: f (x-1) :#: r :#: f (x-1) 
          q = Turn 60 
          r = Turn (-60) 

-- 3. sierpinski 

sierpinski :: Int -> Command 
sierpinski x =f x
    where f 0 = Go 10 
          f x = g (x-1):#:q :#: f (x-1):#:q :#: g (x-1) 
          g 0 = Go 10 
          g x = f (x-1):#:r :#: g (x-1):#:r :#: f (x-1) 
          q = Turn 60 
          r = Turn (-60) 

      

-- 4. hilbert 

hilbert :: Int -> Command 
hilbert =  undefined 
 

-- 5. dragon 

dragon :: Int -> Command 
dragon =  undefined 

 

-- ** Optional Material 

 

-- 6a. split 

split :: Command -> [Command] 
split Sit = [] 
split (Go d) = [Go d] 
split (Turn a) =[Turn a] 
split (c :#: d) = (split c) ++ (split d) 
split (GrabPen p) = [GrabPen p] 
split (Branch c) = (split c) 

 

-- 6b. join 

join :: [Command] -> Command 
join [] = Sit 
join (x:xs) = x :#: join xs



-- 6c. equivalent 

equivalent :: Command -> Command -> Bool 
equivalent c d = split c == split d

prop_split_join :: Command -> Bool 
prop_split_join c = equivalent  (join (split c))  c


prop_split :: Command -> Bool 
prop_split (a :#:b ) = [a :#:b ] /= split (a :#:b ) && notElem Sit (split (a :#:b))
prop_split (Branch c) = prop_split c
prop_split c = notElem Sit (split c)


-- 7. optimise 

optimise :: Command -> Command 
optimise (Turn a) | a == 0 = Sit
                  | otherwise = Turn a
optimise (Go d) | d == 0 = Sit
                | otherwise = Go d
optimise Sit = Sit
optimise (GrabPen p) = GrabPen p
optimise (Branch c) = Branch (optimise c)
optimise ((Go a) :#: (Go b)) = Go (a+b)
optimise ((Turn a) :#: (Turn b)) = Turn (a+b)
optimise (a :#: Sit) = optimise a
optimise (Sit :#: a) = optimise a
optimise (t:#:r) = optimise (optimise t :#: optimise r)


 