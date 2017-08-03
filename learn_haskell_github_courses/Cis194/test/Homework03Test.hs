{-# OPTIONS_GHC -Wall #-}
module Homework03Test(testHomework03) where
import Log
import Homework03 (
    skips,
    )
import Test.Hspec (
    Spec,
    describe,
    shouldBe,
    it,
    hspec,
    )

emptyIntList :: [Int]
emptyIntList = []

spec :: Spec
spec = describe "HSpec Tests" $ do
  describe "skips" $ do
    let input `shouldReturn` expected = skips input `shouldBe` expected
    it "works on a string"    $ "ABCD"        `shouldReturn` ["ABCD", "BD", "C", "D"]
    it "works on Bools"       $ [True, False] `shouldReturn` [[True, False], [False]]
    it "works on empty lists" $ emptyIntList  `shouldReturn` [emptyIntList]
-- | Run tests for Homework03
testHomework03 :: IO ()
testHomework03 = do putStrLn "Homework03 Tests"
                    --grab the appropriate pieces of the official file
                    hspec spec
