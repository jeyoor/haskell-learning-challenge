{-# OPTIONS_GHC -Wall #-}
module Homework02Test(testHomework02) where
import Control.Applicative
import Log
import Homework02 (
    parseMessage,
    parse,
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
spec :: String -> String -> Spec
spec officialPart officialWhole = describe "HSpec Tests" $ do

  describe "parseMessage" $ do
    let input `shouldReturn` expected = parseMessage input `shouldBe` expected
    it "works on error log messages" $ "E 2 562 help help" `shouldReturn` LogMessage (Error 2) 562 "help help"
    it "works on info log messages"  $ "I 26 la la la"     `shouldReturn` LogMessage Info 26 "la la la"
    it "works on invalid messages"   $ "This is invalid"   `shouldReturn` Unknown "This is invalid"

  describe "parse" $ do
    let input `shouldReturn` expected = parse input `shouldBe` expected
    it "works on a hardcoded sample file" $
      "E 2 562 help help\nI 26 la la la\nThis is invalid" `shouldReturn`
        [LogMessage (Error 2) 562 "help help",LogMessage Info 26 "la la la",Unknown "This is invalid"]
    it "works on part of the official file" $ officialPart `shouldReturn`
        [LogMessage Info 5053 "pci_id: con ing!",
         LogMessage Info 4681 "ehci 0xf43d000:15: regista14: [0xbffff 0xfed nosabled 00-02] Zonseres: brips byted nored)",
         LogMessage Warning 3654 "e8] PGTT ASF! 00f00000003.2: 0x000 - 0000: 00009dbfffec00000: Pround/f1743colled",
         LogMessage Info 4076 "verse.'",
         LogMessage Info 4764 "He trusts to you to set them free,",
         LogMessage Info 858 "your pocket?' he went on, turning to Alice.",
         LogMessage Info 898 "would be offended again.",
         LogMessage Info 3753 "pci 0x18fff steresocared, overne: 0000 (le wailan0: ressio0/derveld fory: alinpu-all)",
         LogMessage Info 790 "those long words, and, what's more, I don't believe you do either!' And",
         LogMessage Info 3899 "hastily."]

--QuickCheck Tests

-- | Run tests for Homework02
testHomework02 :: IO ()
testHomework02 = do putStrLn "Homework02 Tests"
                    --grab the appropriate pieces of the official file
                    officialWhole <- readFile "res/Homework02/error.log"
                    let officialPart = unlines . take 10 $ lines officialWhole
                    hspec $ spec officialPart officialWhole
                    putStr "\n"
