module Homework01Test(
    testHomework01,
    ) where
import Homework01 (
    toDigits,
    toDigitsRev,
    myReverse,
    doubleEveryOther,
    sumDigits,
    validate,
    )
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

testToDigits1 :: Test
testToDigits1 = TestCase (assertEqual "for (toDigits (1234))," ([1, 2, 3, 4]) (toDigits 1234))

testToDigits2 :: Test
testToDigits2 = TestCase (assertEqual "for (toDigits (-17))," ([]) (toDigits (-17)))

testToDigitsRev1 :: Test
testToDigitsRev1 = TestCase (assertEqual "for (toDigitsRev (1234))," ([4, 3, 2, 1]) (toDigitsRev 1234))

testToDigitsRev2 :: Test
testToDigitsRev2 = TestCase (assertEqual "for (toDigitsRev (-17))," ([]) (toDigitsRev (-17)))

hTests = TestList [TestLabel "Test toDigits pos"    testToDigits1,
                   TestLabel "Test toDigits neg"    testToDigits2,
                   TestLabel "Test toDigitsRev pos" testToDigitsRev1,
                   TestLabel "Test toDigitsRev neg" testToDigitsRev2]
--QuickCheck Tests

prop_myReverse nums = myReverse nums == reverse nums

-- | Run tests for Homework01
testHomework01 :: IO ()
testHomework01 = do putStrLn "Homework01 Tests"
                    putStrLn "---HUnit---"
                    runTestTT hTests
                    putStrLn "---QuickCheck---"
                    quickCheck prop_myReverse
