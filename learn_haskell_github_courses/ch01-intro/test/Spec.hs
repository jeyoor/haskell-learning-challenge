{-# LANGUAGE ScopedTypeVariables, TemplateHaskell #-}
module Main where
import qualified Test.QuickCheck as Q
import qualified Test.HUnit      as H
import qualified Lecture01       as L01

--HUnit Tests

l01TestFooNeg :: H.Test
l01TestFooNeg = H.TestCase (H.assertEqual "for (foo (-3))," (0) (L01.foo (-3)))
l01TestFoo1 :: H.Test
l01TestFoo1 = H.TestCase (H.assertEqual "for (foo 1)," (3) (L01.foo 1))
l01TestFoo36 :: H.Test
l01TestFoo36 = H.TestCase (H.assertEqual "for (foo 36)," (-43) (L01.foo 36))

l01Tests :: H.Test
l01Tests = H.TestList [H.TestLabel "Test foo Negative" l01TestFooNeg,
                       H.TestLabel "Test foo 1"        l01TestFoo1,
                       H.TestLabel "Test foo 36"       l01TestFoo36]

--QuickCheck Tests
prop_isEven num = L01.isEven num == even num

main :: IO ()
main = do putStrLn "\nLecture01 Tests"
          putStrLn "Running HUnit Tests"
          hUnitResults <- H.runTestTT l01Tests
          putStrLn (H.showCounts hUnitResults)
          putStrLn "Running QuickCheck Tests"
          Q.quickCheck prop_isEven
