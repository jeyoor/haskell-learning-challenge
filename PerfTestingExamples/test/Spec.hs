{-# OPTIONS_GHC -Wall #-}
import Lib (
    myReverseAppend,
    myReverseAccum,
    )
import Test.QuickCheck(property)
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
    it "reverses 1 thru 5" $ (myReverseAppend ([1,2,3,4,5]::[Integer])) `shouldBe` [5,4,3,2,1]
    it "is equivalent to reverse" $ property $
      \n -> myReverseAppend n == reverse (n::[Integer])
  describe "myReverseAccum" $ do
    it "reverses 1 thru 5" $ (myReverseAccum ([1,2,3,4,5]::[Integer])) `shouldBe` [5,4,3,2,1]
    it "is equivalent to reverse" $ property $
      \n -> myReverseAppend n == reverse (n::[Integer])

main :: IO ()
main = hspec spec
