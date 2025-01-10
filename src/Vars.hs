module Vars
  ( -- testVars,
 -- Vars (allVars),
 -- freshVars,
  )
where

import Test.QuickCheck
import Base.Type

class Vars a where
  allVars:: a -> [VarName]

instance Vars Term where
  allVars (Var name) = [name]
  allVars (Comb _ []) = []
  allVars (Comb _ (t:ts)) = allVars t ++ allVars (Comb "" ts)

instance Vars Rule where
  allVars (Rule t terms) = noDuplicates ((allVars t) ++ (foldl (\names term -> names ++ (allVars term)) [] terms))

instance Vars Prog where
  allVars (Prog rules) = noDuplicates (foldl (\names rule -> names ++ (allVars rule)) [] rules)

instance Vars Goal where
  allVars (Goal terms) = noDuplicates (foldl (\names term -> names ++ (allVars term)) [] terms)

freshVars:: [VarName]
freshVars = map VarName (helper 0)
  where
    helper 0 = letters ++ helper 1
    helper x = map (\str -> str ++ (show (x-1))) (letters) ++ helper (x+1)
    letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

-- Helping Hands...

noDuplicates :: Eq a => [a] -> [a]
noDuplicates [] = []
noDuplicates (x:xs) =   if (elem x xs)
                        then noDuplicates xs 
                        else [x] ++ noDuplicates xs

{- Uncomment this to test the properties when all required functions are implemented

spec :: Int -> Property
spec n = (n >= 0) && (n <= 100) ==> freshVars !! (n * 26)  == VarName ("A" ++ str)
  where str = if n == 0 then "" else show (n - 1)

-- Run tests
testVars :: IO ()
testVars = quickCheck spec
-}