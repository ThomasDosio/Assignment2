module Project ( prove, proveCount ) where
import Data.List
import Sequent

prove :: Sequent -> [Sequent]
prove sequent= getridofduplicates (repeatuntilcantbedone (joinrules notnot (joinrules ifonlyifL (joinrules ifonlyifR (joinrules ifthenR (joinrules ifthenL (joinrules notL (joinrules notR  (joinrules identity (joinrules andL (joinrules orR (joinrules andR   orL )))))))))))  (removeduplicate sequent))

type Rule = Sequent -> Maybe [Sequent]

andR :: Rule
andR sequent | isrightand sequent = Just [leftside sequent  :|=: [firsthalfand (head (rightside sequent))], leftside sequent  :|=: [secondhalfand (head (rightside sequent))]]
             | containsrightand sequent = Just [(leftside sequent  :|=: ((firsthalfand (head (firstandpartofrightside))): otherpartofrightside)), (leftside sequent  :|=: ((secondhalfand (head (firstandpartofrightside))): otherpartofrightside))]
             | otherwise = Nothing
                where firstandpartofrightside = [head (filter (isand) (rightside sequent))]
                      otherpartofrightside = filter (not . (`elem` firstandpartofrightside)) (rightside sequent)

andL :: Rule
andL sequent | isleftand sequent = Just [(firsthalfand (head (leftside sequent)) : (secondhalfand (head (leftside sequent)) : tail (leftside sequent))) :|=: rightside sequent ]
             | containsleftand sequent = Just [(firsthalfand (head firstandpartofleftside) : (secondhalfand (head (firstandpartofleftside)): everythingelse)) :|=: rightside sequent]
             | otherwise = Nothing
                where firstandpartofleftside = [head (filter (isand) (leftside sequent))]
                      everythingelse = filter (not . (`elem` firstandpartofleftside)) (leftside sequent)


orL :: Rule
orL sequent | isleftor sequent = Just [[firsthalfor (head (leftside sequent))] :|=: rightside sequent, [secondhalfor (head (leftside sequent))] :|=: rightside sequent]
            | containsleftor sequent = Just [(firsthalfor (head (firstorpartofleftside)) : everythingelse) :|=: rightside sequent, (secondhalfor (head firstorpartofleftside) : everythingelse) :|=: rightside sequent]
            | otherwise = Nothing
               where firstorpartofleftside = [head (filter (isor) (leftside sequent))]
                     everythingelse = filter (not . (`elem` firstorpartofleftside)) (leftside sequent)

orR :: Rule
orR sequent | isrightor sequent = Just [leftside sequent :|=: (firsthalfor (head (rightside sequent)) : (secondhalfor (head (rightside sequent)) : tail (rightside sequent)))]
            | containsrightor sequent = Just [leftside sequent :|=: (firsthalfor (head firstorpartofrightside) : (secondhalfor (head firstorpartofrightside) : everythingelse))]
            | otherwise = Nothing
               where firstorpartofrightside = [head (filter (isor) (rightside sequent))]
                     everythingelse =  filter (not . (`elem` firstorpartofrightside)) (rightside sequent)

identity :: Rule
identity sequent | leftside sequent == rightside sequent = Just []
                 | not (null [x | x<- (leftside sequent), elem x (rightside sequent)]) = Just []
                 | otherwise = Nothing

notL :: Rule
notL sequent | isleftnot sequent = Just [[]:|=: insideofnot (head (leftside sequent)) : (rightside sequent)]
             | containsleftnot sequent = Just [filter (not. isnot) (leftside sequent) :|=: map insideofnot (filter (isnot) (leftside sequent)) ++ (rightside sequent)]
             | otherwise = Nothing

notR :: Rule
notR sequent | isrightnot sequent = Just [insideofnot (head (rightside sequent)) : (leftside sequent) :|=: []]
             | containsrightnot sequent = Just [map insideofnot (filter (isnot) (rightside sequent)) ++ (leftside sequent) :|=: filter (not. isnot) (rightside sequent)]
             | otherwise = Nothing

notnot :: Rule
notnot sequent | isnotnot (rightside sequent) = Just [leftside sequent :|=: [nonot (head (rightside sequent ))]]
               | isnotnot (leftside sequent) = Just [[nonot (head (rightside sequent ))] :|=: rightside sequent]
               | containsnotnot (rightside sequent) = Just [leftside sequent :|=: (nonot (head (filter (isnotnot2) (rightside sequent))) :  filter ( /= (head (filter (isnotnot2) (rightside sequent)))) (rightside sequent))]
               | containsnotnot (leftside sequent) = Just [ (nonot (head (filter (isnotnot2) (leftside sequent))) :  filter ( /= (head (filter (isnotnot2) (leftside sequent)))) (leftside sequent)) :|=: rightside sequent]
               | otherwise = Nothing

ifthenR :: Rule
ifthenR sequent | isifthen (rightside sequent) = Just [if' (head (rightside sequent)) : (leftside sequent)  :|=:  [then' (head (rightside sequent))] ]
                | containsifthen (rightside sequent) = Just [if' (head (filter (isifthen2 ) (rightside sequent))) :  (leftside sequent) :|=:  then' (head (filter (isifthen2 ) (rightside sequent))) : (filter (/=(head (filter (isifthen2 ) (rightside sequent)))) (rightside sequent))]
                | otherwise = Nothing

ifthenL :: Rule
ifthenL sequent | isifthen (leftside sequent) = Just [ tail (leftside sequent) :|=: if' (head (leftside sequent)) : (rightside sequent), then' (head (leftside sequent)) : tail (leftside sequent) :|=:  (rightside sequent)]
                | containsifthen (leftside sequent) = Just [filter (/= (head (filter (isifthen2 ) (leftside sequent)))) (leftside sequent) :|=: if' (head (filter (isifthen2 ) (leftside sequent))) : rightside sequent, then' (head (filter (isifthen2 ) (leftside sequent))) : filter (/= (head (filter (isifthen2 ) (leftside sequent)))) ((leftside sequent)) :|=: rightside sequent]
                | otherwise = Nothing

ifonlyifL :: Rule
ifonlyifL sequent | isifonlyif (leftside sequent) = Just [[firstif (head (leftside sequent)) :->: secondif (head (leftside sequent)), secondif (head (leftside sequent)) :->: firstif (head (leftside sequent))] :|=: rightside sequent]
                  | containsifonlyif (leftside sequent) = Just [(firstif (head (filter (isifonlyif2) (leftside sequent))) :->: (secondif (head (filter (isifonlyif2) (leftside sequent))))): (secondif (head (filter (isifonlyif2) (leftside sequent))) :->: firstif (head (filter (isifonlyif2) (leftside sequent)))) : filter (not . isifonlyif2) (leftside sequent) :|=: rightside sequent]
                  | otherwise = Nothing

ifonlyifR :: Rule
ifonlyifR sequent | isifonlyif (rightside sequent) = Just [firstif (head (rightside sequent)) :->:secondif (head (rightside sequent)) : (leftside sequent) :|=: [ secondif (head (rightside sequent)):->: firstif (head (rightside sequent))]]
                  | containsifonlyif (rightside sequent) = Just [firstif (head (filter (isifonlyif2) (rightside sequent))) :->: secondif (head (filter (isifonlyif2) (rightside sequent))) : (leftside sequent) :|=:  secondif (head (filter (isifonlyif2) (rightside sequent))) :->: firstif (head (filter (isifonlyif2) (rightside sequent))) : filter (/= head (filter (isifonlyif2) (rightside sequent))) (rightside sequent)]
                  | otherwise = Nothing

isifonlyif :: [Prop] -> Bool
isifonlyif props = length props == 1 && and (map (isifonlyif2) props)

isifonlyif2 :: Prop -> Bool
isifonlyif2 (a:<->: b) = True
isifonlyif2 p = False

firstif :: Prop -> Prop
firstif (p:<->:q) = p

secondif :: Prop -> Prop
secondif (p:<->:q) = q

containsifonlyif :: [Prop] -> Bool
containsifonlyif props = not (null (filter (isifonlyif2) props))

isifthen :: [Prop] -> Bool
isifthen props = length props == 1 && isifthen2 (head props)

isifthen2 :: Prop -> Bool
isifthen2 (p:->: q) = True
isifthen2 _ = False

containsifthen :: [Prop] -> Bool
containsifthen props = not (null (filter (isifthen2) props))

if' :: Prop -> Prop
if' (p:->:q) = p

then' :: Prop -> Prop
then' (p:->:q) = q

p = [Var "a" :->: Var "b" ]:|=:[ Not (Var "b") :->: Not (Var "b")]

getridofduplicates :: [Sequent] -> [Sequent]
getridofduplicates sequents = nub (map removeduplicate sequents)

removeduplicate :: Sequent -> Sequent
removeduplicate sequent = sort (nub (leftside sequent)) :|=: sort (nub (rightside sequent))


joinrules :: Rule -> Rule -> Rule
joinrules f g sequent | f sequent== Nothing && g sequent == Nothing = Nothing
                      | f sequent /= Nothing && g sequent == Nothing = f sequent
                      | f sequent == Nothing && g sequent /= Nothing = g sequent
                      | f sequent /= Nothing && g sequent /= Nothing = Just (concatMap (fix .g) (fix (f sequent)))

repeatuntilcantbedone :: Rule -> Sequent -> [Sequent]
repeatuntilcantbedone function sequent | function (sequent) == Nothing = [sequent]
                                       | otherwise = concatMap (repeatuntilcantbedone (function)) (fix (function sequent))



w = [Not (Var "w" :||: Var "d"), Var "e"] :|=: [(Var "w" :||: Var "d" :&&: Var "p") :&&: Var "e"]

test :: Sequent
test = [] :|=: [((Not (Var "e" :&&: (Var "f" :&&: (Not (Not (Var "c")))))) :||: ((Not (Var "a") :||: Var "c")))]

fix :: Maybe a -> a
fix (Just a) = a


leftside :: Sequent -> [Prop]
leftside (a :|=: b) = a

rightside :: Sequent -> [Prop]
rightside (a :|=: b) = b

isand :: Prop -> Bool
isand (a:&&:b) = True
isand _ = False

isor:: Prop -> Bool
isor (a:||:b) = True
isor _ = False

isnot :: Prop -> Bool
isnot (Not p) = True
isnot _ = False

containsand :: [Prop] -> Bool
containsand props= or [isand x | x <- props]

containsor:: [Prop]-> Bool
containsor props= or [isor x | x <- props]

containsnot :: [Prop] -> Bool
containsnot props = or [isnot x | x<- props]

isrightand :: Sequent -> Bool
isrightand sequent | length (rightside sequent)== 1 &&  isand (head (rightside sequent)) = True
                   | otherwise = False

containsrightand :: Sequent -> Bool
containsrightand sequent = containsand (rightside sequent)

isrightor :: Sequent -> Bool
isrightor sequent  | length (rightside sequent)== 1 &&  isor (head (rightside sequent)) = True
                   | otherwise = False

containsrightor :: Sequent -> Bool
containsrightor sequent = containsor (rightside sequent)

isleftand :: Sequent -> Bool
isleftand sequent  | length (leftside sequent)== 1 &&  isand (head (leftside sequent)) = True
                   | otherwise = False

containsleftand :: Sequent -> Bool
containsleftand sequent = containsand (leftside sequent)

isleftor :: Sequent -> Bool
isleftor sequent | length (leftside sequent) == 1 && isor (head (leftside sequent)) = True
                 | otherwise = False

containsleftor :: Sequent -> Bool
containsleftor sequent = containsor (leftside sequent)

isleftnot :: Sequent -> Bool
isleftnot sequent | length (leftside sequent) == 1 && isnot (head (leftside sequent)) = True
                  | otherwise = False

containsleftnot :: Sequent -> Bool
containsleftnot sequent = containsnot (leftside sequent)

isrightnot :: Sequent -> Bool
isrightnot sequent | length (rightside sequent) == 1 && isnot (head (rightside sequent)) = True
                   | otherwise = False

containsrightnot :: Sequent -> Bool
containsrightnot sequent = containsnot (rightside sequent)

firsthalfand :: Prop -> Prop
firsthalfand (a:&&:b) = a

secondhalfand :: Prop -> Prop
secondhalfand (a:&&:b) =b

firsthalfor :: Prop -> Prop
firsthalfor (a:||:b) = a

secondhalfor :: Prop -> Prop
secondhalfor (a:||:b) =b

insideofnot :: Prop -> Prop
insideofnot (Not p) = p

isnotnot :: [Prop] -> Bool
isnotnot props = length props == 1 && isnotnot2 (head props)

isnotnot2 :: Prop -> Bool
isnotnot2 (Not (Not p)) = True
isnotnot2 _ = False

nonot :: Prop -> Prop
nonot (Not (Not p)) = p

containsnotnot :: [Prop] -> Bool
containsnotnot props = not (null (filter (isnotnot2) props))

a = Var "a"
b = Var "b"
c = Var "c"
d = Var "d"
e = Var "e"
f = Var "f"
y= ([] :|=: [Not((Not a :||: b) :&&: (Not c :||: b)) :||: Not a :||: c ])
t= [ [a, b] :|=: [c] ]
prop3 = prove y == t

q =[(a :->: b)] :|=: [((Not b) :->: (Not a))]

m = [((c :||: d) :->: (d :&&: f)),((a :<->: a) :<->: (b :||: a))] :|=: [((c :<->: b) :<->: (b :->: a)),(Not (b :||: d)),(Not (b :&&: d)),((d :<->: f) :->: (c :||: e))]
sol = [ [b, a, f, d] :|=: [c, e] ]

lm = [ (f :||: b) :&&: (b :->: d), (e :||: d) :||: Not e, (f :->: e) :->: Not f, (e :||: d) :&&: (d :<->: c), Not(c :<->: b), Not f :&&: (a :&&: a), (f :<->: c) :->: (c :||: f )] :|=: [((e :&&: f ) :||: (f :&&: a)), Not f :&&: Not d, (f :||: c) :<->:(f :<->: b) ]


-- for challenge part

proveCount :: Sequent -> ([Sequent],Int)
proveCount = undefined


module Project ( prove, proveCount ) where
import Data.List
import Sequent

prove :: Sequent -> [Sequent]
prove sequent= getridofduplicates (repeatuntilcantbedone helper (sequent))

type Rule = Sequent -> Maybe [Sequent]

helper :: Rule
helper sequent    | isnotnot (rightside sequent) = Just [leftside sequent :|=: [nonot (head (rightside sequent ))]]
                  | isnotnot (leftside sequent) = Just [[nonot (head (rightside sequent ))] :|=: rightside sequent]
                  
                  | leftside sequent == rightside sequent = Just []
                  | not (null [x | x<- (leftside sequent), elem x (rightside sequent)]) = Just []

                  | containsnotnot (rightside sequent) = Just [leftside sequent :|=: (nonot (head (filter (isnotnot2) (rightside sequent))) :  filter ( /= (head (filter (isnotnot2) (rightside sequent)))) (rightside sequent))]
                  | containsnotnot (leftside sequent) = Just [ (nonot (head (filter (isnotnot2) (leftside sequent))) :  filter ( /= (head (filter (isnotnot2) (leftside sequent)))) (leftside sequent)) :|=: rightside sequent]
                  
                  | isleftnot sequent = Just [[]:|=: insideofnot (head (leftside sequent)) : (rightside sequent)]
                  | containsleftnot sequent = Just [filter (not. isnot) (leftside sequent) :|=: map insideofnot (filter (isnot) (leftside sequent)) ++ (rightside sequent)]
                  
                  | isrightnot sequent = Just [insideofnot (head (rightside sequent)) : (leftside sequent) :|=: []]
                  | containsrightnot sequent = Just [map insideofnot (filter (isnot) (rightside sequent)) ++ (leftside sequent) :|=: filter (not. isnot) (rightside sequent)]
                  
                  | isifonlyif (leftside sequent) = Just [[firstif (head (leftside sequent)) :->: secondif (head (leftside sequent)), secondif (head (leftside sequent)) :->: firstif (head (leftside sequent))] :|=: rightside sequent]
                  | containsifonlyif (leftside sequent) = Just [(firstif (head (filter (isifonlyif2) (leftside sequent))) :->: (secondif (head (filter (isifonlyif2) (leftside sequent))))): (secondif (head (filter (isifonlyif2) (leftside sequent))) :->: firstif (head (filter (isifonlyif2) (leftside sequent)))) : filter (not . isifonlyif2) (leftside sequent) :|=: rightside sequent]
                  
                  | isifonlyif (rightside sequent) = Just [firstif (head (rightside sequent)) :->:secondif (head (rightside sequent)) : (leftside sequent) :|=: [ secondif (head (rightside sequent)):->: firstif (head (rightside sequent))]]
                  | containsifonlyif (rightside sequent) = Just [ (leftside sequent) :|=:   firstif (head (filter (isifonlyif2) (rightside sequent))) :->: secondif (head (filter (isifonlyif2) (rightside sequent))) : filter (/= head (filter (isifonlyif2) (rightside sequent))) (rightside sequent), (leftside sequent) :|=:  secondif (head (filter (isifonlyif2) (rightside sequent))) :->: firstif (head (filter (isifonlyif2) (rightside sequent))) : filter (/= head (filter (isifonlyif2) (rightside sequent))) (rightside sequent) ]
                  
                  | isifthen (leftside sequent) = Just [ tail (leftside sequent) :|=: if' (head (leftside sequent)) : (rightside sequent), then' (head (leftside sequent)) : tail (leftside sequent) :|=:  (rightside sequent)]
                  | containsifthen (leftside sequent) = Just [filter (/= (head (filter (isifthen2 ) (leftside sequent)))) (leftside sequent) :|=: if' (head (filter (isifthen2 ) (leftside sequent))) : rightside sequent, then' (head (filter (isifthen2 ) (leftside sequent))) : filter (/= (head (filter (isifthen2 ) (leftside sequent)))) ((leftside sequent)) :|=: rightside sequent]
                  
                  | isifthen (rightside sequent) = Just [if' (head (rightside sequent)) : (leftside sequent)  :|=:  [then' (head (rightside sequent))] ]
                  | containsifthen (rightside sequent) = Just [if' (head (filter (isifthen2 ) (rightside sequent))) :  (leftside sequent) :|=:  then' (head (filter (isifthen2 ) (rightside sequent))) : (filter (/=(head (filter (isifthen2 ) (rightside sequent)))) (rightside sequent))]
                  
                  | isrightand sequent = Just [leftside sequent  :|=: [firsthalfand (head (rightside sequent))], leftside sequent  :|=: [secondhalfand (head (rightside sequent))]]
                  | containsrightand sequent = Just [(leftside sequent  :|=: ((firsthalfand (head (firstandpartofrightside))): otherpartofrightside)), (leftside sequent  :|=: ((secondhalfand (head (firstandpartofrightside))): otherpartofrightside))]
                  
                  | isleftand sequent = Just [(firsthalfand (head (leftside sequent)) : (secondhalfand (head (leftside sequent)) : tail (leftside sequent))) :|=: rightside sequent ]
                  | containsleftand sequent = Just [(firsthalfand (head firstandpartofleftside) : (secondhalfand (head (firstandpartofleftside)): everythingelse1)) :|=: rightside sequent]
                  
                  | isleftor sequent = Just [[firsthalfor (head (leftside sequent))] :|=: rightside sequent, [secondhalfor (head (leftside sequent))] :|=: rightside sequent]
                  | containsleftor sequent = Just [(firsthalfor (head (firstorpartofleftside)) : everythingelse2) :|=: rightside sequent, (secondhalfor (head firstorpartofleftside) : everythingelse2) :|=: rightside sequent]
                  
                  | isrightor sequent = Just [leftside sequent :|=: (firsthalfor (head (rightside sequent)) : (secondhalfor (head (rightside sequent)) : tail (rightside sequent)))]
                  | containsrightor sequent = Just [leftside sequent :|=: (firsthalfor (head firstorpartofrightside) : (secondhalfor (head firstorpartofrightside) : everythingelse3))]


                  |otherwise = Nothing

                where firstandpartofrightside = [head (filter (isand) (rightside sequent))]
                      otherpartofrightside = filter (not . (`elem` firstandpartofrightside)) (rightside sequent)
                      firstandpartofleftside = [head (filter (isand) (leftside sequent))]
                      everythingelse1 = filter (not . (`elem` firstandpartofleftside)) (leftside sequent)
                      firstorpartofleftside = [head (filter (isor) (leftside sequent))]
                      everythingelse2 = filter (not . (`elem` firstorpartofleftside)) (leftside sequent)
                      firstorpartofrightside = [head (filter (isor) (rightside sequent))]
                      everythingelse3 =  filter (not . (`elem` firstorpartofrightside)) (rightside sequent)

isifonlyif :: [Prop] -> Bool
isifonlyif props = length props == 1 && and (map (isifonlyif2) props)

isifonlyif2 :: Prop -> Bool
isifonlyif2 (p :<->: q) = True
isifonlyif2 p = False

firstif :: Prop -> Prop
firstif (p:<->:q) = p

secondif :: Prop -> Prop
secondif (p:<->:q) = q

containsifonlyif :: [Prop] -> Bool
containsifonlyif props = not (null (filter (isifonlyif2) props))

isifthen :: [Prop] -> Bool
isifthen props = length props == 1 && isifthen2 (head props)

isifthen2 :: Prop -> Bool
isifthen2 (p :->: q) = True
isifthen2 _ = False

containsifthen :: [Prop] -> Bool
containsifthen props = not (null (filter (isifthen2) props))

testcase =[((Var "e" :&&: Var "f") :<->: (Var "a" :&&: Var "e")),((Var "b" :||: Var "d") :&&: (Var "f" :<->: Var "c")),(Not (Var "d" :<->: Var "f")),((Var "d" :&&: Var "e") :||: (Var "c" :->: Var "f")),((Var "e" :<->: Var "f") :<->: (Var "b" :||: Var "d"))] :|=: [((Var "e" :||: Var "d") :&&: (Not (Var "e")))]

if' :: Prop -> Prop
if' (p:->:q) = p

then' :: Prop -> Prop
then' (p:->:q) = q


getridofduplicates :: [Sequent] -> [Sequent]
getridofduplicates sequents = nub (map removeduplicate sequents)

removeduplicate :: Sequent -> Sequent
removeduplicate sequent =  sort (nub (leftside sequent)) :|=: sort (nub (rightside sequent))


joinrules :: Rule -> Rule -> Rule
joinrules f g sequent | f sequent== Nothing && g sequent == Nothing = Nothing
                      | f sequent /= Nothing && g sequent == Nothing = f sequent
                      | f sequent == Nothing && g sequent /= Nothing = g sequent
                      | f sequent /= Nothing && g sequent /= Nothing = Just (concatMap (fix .g) (fix (f sequent)))

repeatuntilcantbedone :: Rule -> Sequent -> [Sequent]
repeatuntilcantbedone function sequent | function (sequent) == Nothing = [sequent]
                                       | otherwise = concatMap (repeatuntilcantbedone (function)) (fix (function sequent))



fix :: Maybe [Sequent] -> [Sequent]
fix (Just a) = a


leftside :: Sequent -> [Prop]
leftside (a :|=: b) = a

rightside :: Sequent -> [Prop]
rightside (a :|=: b) = b

isand :: Prop -> Bool
isand (a:&&:b) = True
isand _ = False

isor:: Prop -> Bool
isor (a:||:b) = True
isor _ = False

isnot :: Prop -> Bool
isnot (Not p) = True
isnot _ = False

containsand :: [Prop] -> Bool
containsand props= or [isand x | x <- props]

containsor:: [Prop]-> Bool
containsor props= or [isor x | x <- props]

containsnot :: [Prop] -> Bool
containsnot props = or [isnot x | x<- props]

isrightand :: Sequent -> Bool
isrightand sequent | length (rightside sequent)== 1 &&  isand (head (rightside sequent)) = True
                   | otherwise = False

containsrightand :: Sequent -> Bool
containsrightand sequent = containsand (rightside sequent)

isrightor :: Sequent -> Bool
isrightor sequent  | length (rightside sequent)== 1 &&  isor (head (rightside sequent)) = True
                   | otherwise = False

containsrightor :: Sequent -> Bool
containsrightor sequent = containsor (rightside sequent)

isleftand :: Sequent -> Bool
isleftand sequent  | length (leftside sequent)== 1 &&  isand (head (leftside sequent)) = True
                   | otherwise = False

containsleftand :: Sequent -> Bool
containsleftand sequent = containsand (leftside sequent)

isleftor :: Sequent -> Bool
isleftor sequent | length (leftside sequent) == 1 && isor (head (leftside sequent)) = True
                 | otherwise = False

containsleftor :: Sequent -> Bool
containsleftor sequent = containsor (leftside sequent)

isleftnot :: Sequent -> Bool
isleftnot sequent | length (leftside sequent) == 1 && isnot (head (leftside sequent)) = True
                  | otherwise = False

containsleftnot :: Sequent -> Bool
containsleftnot sequent = containsnot (leftside sequent)

isrightnot :: Sequent -> Bool
isrightnot sequent | length (rightside sequent) == 1 && isnot (head (rightside sequent)) = True
                   | otherwise = False

containsrightnot :: Sequent -> Bool
containsrightnot sequent = containsnot (rightside sequent)

firsthalfand :: Prop -> Prop
firsthalfand (a:&&:b) = a

secondhalfand :: Prop -> Prop
secondhalfand (a:&&:b) =b

firsthalfor :: Prop -> Prop
firsthalfor (a:||:b) = a

secondhalfor :: Prop -> Prop
secondhalfor (a:||:b) =b

insideofnot :: Prop -> Prop
insideofnot (Not p) = p

isnotnot :: [Prop] -> Bool
isnotnot props = length props == 1 && isnotnot2 (head props)

isnotnot2 :: Prop -> Bool
isnotnot2 (Not (Not p)) = True
isnotnot2 _ = False

nonot :: Prop -> Prop
nonot (Not (Not p)) = p

containsnotnot :: [Prop] -> Bool
containsnotnot props = not (null (filter (isnotnot2) props))

-- for challenge part

proveCount :: Sequent -> ([Sequent],Int)
proveCount = undefined
