module Vars
  ( -- testVars,
 -- Vars (allVars),
 -- freshVars,
  )
where

import Test.QuickCheck


{- Uncomment this to test the properties when all required functions are implemented

spec :: Int -> Property
spec n = (n >= 0) && (n <= 100) ==> freshVars !! (n * 26)  == VarName ("A" ++ str)
  where str = if n == 0 then "" else show (n - 1)

-- Run tests
testVars :: IO ()
testVars = quickCheck spec
-}