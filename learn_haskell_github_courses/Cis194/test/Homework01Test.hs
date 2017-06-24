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

testDoubleEveryOther1 :: Test
testDoubleEveryOther1 = TestCase (assertEqual "for (doubleEveryOther [1, 2, 3])," ([1, 4, 3]) (doubleEveryOther [1, 2, 3]))

testDoubleEveryOther2 :: Test
testDoubleEveryOther2 = TestCase (assertEqual "for (doubleEveryOther [8, 7, 6, 5])," ([16, 7, 12, 5]) (doubleEveryOther [8, 7, 6, 5]))

testSumDigits1 :: Test
testSumDigits1 = TestCase (assertEqual "for (sumDigits [16, 7, 12 ,5])," 22 (sumDigits [16, 7, 12, 5]))

testSumDigits2 :: Test
testSumDigits2 = TestCase (assertEqual "for (sumDigits [])," (0) (sumDigits []))

testValidate1 :: Test
testValidate1 = TestCase (assertEqual "for (validate 4012888888881881)," True (validate 4012888888881881))

testValidate2 :: Test
testValidate2 = TestCase (assertEqual "for (validate 4012888888881882)," False (validate 4012888888881882))

hTests = TestList [TestLabel "Test toDigits pos"      testToDigits1,
                   TestLabel "Test toDigits neg"      testToDigits2,
                   TestLabel "Test toDigitsRev pos"   testToDigitsRev1,
                   TestLabel "Test toDigitsRev neg"   testToDigitsRev2,
                   TestLabel "Test doubleEveryOther1" testDoubleEveryOther1,
                   TestLabel "Test doubleEveryOther2" testDoubleEveryOther2,
                   TestLabel "Test sumDigits"         testSumDigits1,
                   TestLabel "Test sumDigits empty"   testSumDigits2,
                   TestLabel "Test validate1"         testValidate1,
                   TestLabel "Test validate2"         testValidate2]
--QuickCheck Tests

prop_myReverse nums = myReverse nums == reverse nums

-- | Run tests for Homework01
testHomework01 :: IO ()
testHomework01 = do putStrLn "Homework01 Tests"
                    putStrLn "---HUnit---"
                    runTestTT hTests
                    putStrLn "---QuickCheck---"
                    quickCheck prop_myReverse
