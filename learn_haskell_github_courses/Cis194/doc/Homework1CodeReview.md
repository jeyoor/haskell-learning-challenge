I am working through the [UPenn CIS194](https://www.seas.upenn.edu/~cis194/spring13/) lectures and homework assignments in an effort to learn more about Haskell.

The first part of Homework 1 is focused on validating credit card numbers.







##TODO: post this as a comment after posting question.
There is already a question regarding the content of the [first assignment](https://codereview.stackexchange.com/questions/104876/upenn-cis-194-homework-1-validating-credit-card-numbers) (validating credit card numbers).



I am working through the [UPenn CIS194](https://www.seas.upenn.edu/~cis194/spring13/) lectures and homework assignments in an effort to learn more about Haskell.

The functions in my solution are roughly equivalent to those in [this prior question](https://codereview.stackexchange.com/questions/104876/upenn-cis-194-homework-1-validating-credit-card-numbers).

I'd like feedback on the [HUnit]() and [QuickCheck]() tests I wrote while working the assignment.

    module Homework01Test(
        testHomework01,
        ) where
    import Homework01 (
        toDigits,
        toDigitsRev,
        myReverse,
        doubleEveryOther,
        sumDigits,
        sumList,
        sumDigitsFoldWorker,
        validate,
        checkSum,
        hanoi,
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
    
    testSumDigits3 :: Test
    testSumDigits3 = TestCase (assertEqual "for (sumDigits [16, 1, 2, 3, 1, 1, 1])," (16) (sumDigits [16, 1, 2, 3, 1, 1, 1]))
    
    testSumDigits4 :: Test
    testSumDigits4 = TestCase (assertEqual "for (sumDigits [16, 1, 2, 3, 1, 1, 1])," (17) (sumDigits [16, 1, 2, 3, 1, 1, 1, 1]))
    
    testValidate1 :: Test
    testValidate1 = TestCase (assertEqual "for (validate 4012888888881881)," True (validate 4012888888881881))
    
    testValidate2 :: Test
    testValidate2 = TestCase (assertEqual "for (validate 4012888888881882)," False (validate 4012888888881882))
    
    testCheckSum1 :: Test
    testCheckSum1 = TestCase (assertEqual "for (checkSum 1386)," (18) (checkSum 1386))
    
    testHanoi1 :: Test
    testHanoi1 = TestCase (assertEqual "for (hanoi 2 \"a\" \"b\" \"c\")" ([("a","c"), ("a","b"), ("c","b")]) (hanoi 2 "a" "b" "c"))
    
    testHanoi2 :: Test
    testHanoi2 = TestCase (assertEqual "for (hanoi 3 \"left\" \"right\" \"middle\")" ([("left","right"),("left","middle"),("right","middle"),("left","right"),("middle","left"),("middle","right"),("left","right")]) (hanoi 3 "left" "right" "middle"))
    
    hTests = TestList [TestLabel "Test toDigits pos"      testToDigits1,
                       TestLabel "Test toDigits neg"      testToDigits2,
                       TestLabel "Test toDigitsRev pos"   testToDigitsRev1,
                       TestLabel "Test toDigitsRev neg"   testToDigitsRev2,
                       TestLabel "Test doubleEveryOther1" testDoubleEveryOther1,
                       TestLabel "Test doubleEveryOther2" testDoubleEveryOther2,
                       TestLabel "Test sumDigits"         testSumDigits1,
                       TestLabel "Test sumDigits empty"   testSumDigits2,
                       TestLabel "Test sumDigits longer1" testSumDigits3,
                       TestLabel "Test sumDigits longer2" testSumDigits4,
                       TestLabel "Test checkSum"          testCheckSum1,
                       TestLabel "Test hanoi1"            testHanoi1,
                       TestLabel "Test hanoi2"            testHanoi2,
                       TestLabel "Test validate1"         testValidate1,
                       TestLabel "Test validate2"         testValidate2]
    --QuickCheck Tests
    
    prop_myReverse nums = myReverse nums == reverse nums
    prop_sumList nums = sumList nums == sum nums
    
    -- | Run tests for Homework01
    testHomework01 :: IO ()
    testHomework01 = do putStrLn "Homework01 Tests"
                        putStrLn "---HUnit---"
                        runTestTT hTests
                        putStrLn "---QuickCheck---"
                        quickCheck prop_myReverse
                        quickCheck prop_sumList
