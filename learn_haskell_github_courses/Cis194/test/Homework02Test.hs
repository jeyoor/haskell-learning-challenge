{-# OPTIONS_GHC -Wall #-}
module Homework02Test(testHomework02) where
import Log
import Homework02 (
    parseMessage
    )
import Test.QuickCheck(quickCheck)
import Test.Hspec (
    Spec,
    describe,
    shouldReturn,
    shouldBe,
    it,
    hspec,
    )

--HSpec Tests
spec :: Spec
spec = describe "HSpec Tests" $ do

  describe "parseMessage" $ do
    let input `shouldReturn` expected = parseMessage input `shouldBe` expected
    it "works on error log messages" $ "E 2 562 help help" `shouldReturn` LogMessage (Error 2) 562 "help help"
    it "works on info log messages"  $ "I 26 la la la"     `shouldReturn` LogMessage Info 26 "la la la"
    it "works on invalid messages"   $ "This is invalid"   `shouldReturn` Unknown "This is invalid"

--QuickCheck Tests

-- | Run tests for Homework02
testHomework02 :: IO ()
testHomework02 = do putStrLn "Homework02 Tests"
                    hspec spec
                    putStr "\n"
