{-# OPTIONS_GHC -Wall #-}
import Lib (
    myReverseAppend,
    myReverseAccum,
    )
import Test.Hspec (
    Spec,
    describe,
    shouldBe,
    it,
    hspec,
    )
--HSpec Tests
spec :: Spec
spec = describe "HSpec Tests" $ do
  describe "myReverseAppend" $ do
    it "reverses 1 thru 5" $ (myReverseAppend [1,2,3,4,5]) `shouldBe` [5,4,3,2,1]
  describe "myReverseAccum" $ do
    it "reverses 1 thru 5" $ (myReverseAccum [1,2,3,4,5]) `shouldBe` [5,4,3,2,1]

main :: IO ()
main = hspec spec
