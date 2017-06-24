module Lecture01Test(
   testLecture01,
   ) where
import Lecture01(foo, isEven)
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

l01TestFooNeg :: Test
l01TestFooNeg = TestCase (assertEqual "for (foo (-3))," (0) (foo (-3)))
l01TestFoo1 :: Test
l01TestFoo1 = TestCase (assertEqual "for (foo 1)," (3) (foo 1))
l01TestFoo36 :: Test
l01TestFoo36 = TestCase (assertEqual "for (foo 36)," (-43) (foo 36))

l01Tests :: Test
l01Tests = TestList [TestLabel "Test foo Negative" l01TestFooNeg,
                     TestLabel "Test foo 1"        l01TestFoo1,
                     TestLabel "Test foo 36"       l01TestFoo36]

--QuickCheck Tests
prop_isEven num = isEven num == even num

testLecture01 :: IO ()
testLecture01 = do putStrLn "Lecture01 Tests"
                   putStrLn "---HUnit---"
                   runTestTT l01Tests
                   putStrLn "---QuickCheck---"
                   quickCheck prop_isEven
