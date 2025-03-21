{-# LANGUAGE TemplateHaskell #-}

module Rename
  ( --testRename
  , --rename,
  )
where

import Base.Type
import Data.List
import Subst
import Test.QuickCheck
import Vars

rename :: [VarName] -> Rule -> Rule
rename blocklist r@(Rule l rs) = Rule (apply s l) (map (apply s) rs)
  where
    vars = allVars r
    vars' = [x | x <- freshVars, x `notElem` blocklist ++ vars]
    substs = map (\(v,v') -> single v (Var v')) (zip vars vars')
    s = foldr compose empty substs

-- Properties

-- All variables in the renamed rule are fresh
prop_1 :: [VarName] -> Rule -> Bool
prop_1 xs r = null (allVars (rename xs r) `intersect` allVars r)

-- All variables in the renamed rule are not in the blocklist
prop_2 :: [VarName] -> Rule -> Bool
prop_2 xs r = null (allVars (rename xs r) `intersect` xs)

-- The number of variable names in the renamed rule equals number of variable names in the original rule
prop_3 :: [VarName] -> Rule -> Bool
prop_3 xs r = length (nub (allVars (rename xs r))) == length (nub (allVars r))

return []

-- Run all tests
testRename :: IO Bool
testRename = $quickCheckAll
