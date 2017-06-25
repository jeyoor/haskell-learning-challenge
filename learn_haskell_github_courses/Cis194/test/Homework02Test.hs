{-# OPTIONS_GHC -Wall #-}
module Homework02Test where

import Test.QuickCheck(quickCheck)
import Test.HUnit (
    Test,
    Test(TestCase),
    Test(TestLabel),
    Test(TestList),
    assertEqual,
    runTestTT,
    )

--HUnit Tests


--QuickCheck Tests

-- | Run tests for Homework02
testHomework02 :: IO ()
testHomework02 = do putStrLn "Homework02 Tests"
                    putStrLn "---HUnit---"
                    putStrLn "Not implemented yet"
                    --runTestTT hTests
                    putStrLn "---QuickCheck---"
                    putStrLn "Not implemented yet"
                    putStr "\n"
