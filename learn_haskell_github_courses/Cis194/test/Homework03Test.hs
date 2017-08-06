{-# OPTIONS_GHC -Wall #-}
module Homework03Test(testHomework03) where
import Homework03 (
    skips,
    localMaxima,
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
    let input `shouldRet` expected = skips input `shouldBe` expected
    it "works on a string"    $ "ABCD"        `shouldRet` ["ABCD", "BD", "C", "D"]
    it "works on Bools"       $ [True, False] `shouldRet` [[True, False], [False]]
    it "works on empty lists" $ emptyIntList  `shouldRet` [emptyIntList]
  describe "localMaxima" $ do
    let input `shouldRet` expected = localMaxima input `shouldBe` expected
    it "finds two maxima" $ [2,9,5,6,1] `shouldRet` [9,6]
    it "finds one maxima" $ [2,3,4,1,5] `shouldRet` [4]
    it "finds no  maxima" $ [1,2,3,4,5] `shouldRet` []

-- | Run tests for Homework03
testHomework03 :: IO ()
testHomework03 = do putStrLn "Homework03 Tests"
                    --grab the appropriate pieces of the official file
                    hspec spec
