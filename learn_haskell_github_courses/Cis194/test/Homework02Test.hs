{-# OPTIONS_GHC -Wall #-}
module Homework02Test(testHomework02) where
import Control.Applicative
import Log
import Homework02 (
    parseMessage,
    parse,
    insert,
    build,
    inOrder,
    whatWentWrong,
    )
import Test.QuickCheck(quickCheck)
import Test.Hspec (
    Spec,
    describe,
    shouldBe,
    it,
    hspec,
    )

--HSpec Tests
spec :: String -> String -> String -> Spec
spec sampleWhole officialPart officialWhole = describe "HSpec Tests" $ do

  --TODO: test grabNthWord and grabNthWordAndFollowing

  describe "parseMessage" $ do
    let input `shouldReturn` expected = parseMessage input `shouldBe` expected
    it "works on error log messages" $ "E 2 562 help help" `shouldReturn` LogMessage (Error 2) 562 "help help"
    it "works on info log messages"  $ "I 26 la la la"     `shouldReturn` LogMessage Info 26 "la la la"
    it "works on invalid messages"   $ "This is invalid"   `shouldReturn` Unknown "This is invalid"

  describe "parse" $ do
    let input `shouldReturn` expected = parse input `shouldBe` expected
    it "works on a hardcoded sample file" $
      "E 2 562 help help\nI 26 la la la\nThis is invalid" `shouldReturn`
        [LogMessage (Error 2) 562 "help help",
         LogMessage Info 26 "la la la",
         Unknown "This is invalid"]
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

  describe "insert" $ do
    it "works with unknown log messages" $ insert (Unknown "invalid message") Leaf `shouldBe` Leaf
    it "works with inserting later log messages" $
      insert (LogMessage Info 7 "la la")
             (Node
               Leaf
               (LogMessage (Error 10) 3 "This error is chill")
               Leaf)
             `shouldBe`
             (Node
               Leaf
               (LogMessage (Error 10) 3 "This error is chill")
               (Node Leaf (LogMessage Info 7 "la la") Leaf))
    it "works with insert earlier log messages" $
      insert (LogMessage Warning 2 "Early Warning")
             (Node
               Leaf
               (LogMessage (Error 10) 3 "This error is chill")
               Leaf)
             `shouldBe`
             (Node
               (Node Leaf (LogMessage Warning 2 "Early Warning") Leaf)
               (LogMessage (Error 10) 3 "This error is chill")
               Leaf)
    it "works with a deeper tree" $
      insert (LogMessage (Error 28) 13 "This error is dangerous!")
             (Node
               (Node Leaf (LogMessage Warning 3 "Early Warning") Leaf)
               (LogMessage (Error 10) 15 "This error is chill")
               Leaf)
             `shouldBe`
             (Node
               (Node Leaf (LogMessage Warning 3 "Early Warning") 
                 (Node Leaf (LogMessage (Error 28) 13 "This error is dangerous!") Leaf))
               (LogMessage (Error 10) 15 "This error is chill")
               Leaf)

  describe "build" $ do
    it "builds a tree from a short list" $
      build [LogMessage (Error 10) 15 "This error is chill",
             LogMessage Warning 3 "Early Warning",
             LogMessage (Error 28) 13 "This error is dangerous!"]
      `shouldBe`
      (Node
        (Node Leaf (LogMessage Warning 3 "Early Warning") 
          (Node Leaf (LogMessage (Error 28) 13 "This error is dangerous!") Leaf))
        (LogMessage (Error 10) 15 "This error is chill")
        Leaf)

  describe "inOrder" $ do
    it "sorts the tree properly" $
      inOrder (Node
                (Node Leaf (LogMessage Warning 3 "Early Warning") 
                  (Node Leaf (LogMessage (Error 28) 13 "This error is dangerous!") Leaf))
                (LogMessage (Error 10) 15 "This error is chill")
                Leaf)
      `shouldBe`
      [LogMessage Warning 3 "Early Warning",
       LogMessage (Error 28) 13 "This error is dangerous!",
       LogMessage (Error 10) 15 "This error is chill"]

  describe "whatWentWrong" $ do
    it "filters the list properly" $
      whatWentWrong (parse sampleWhole)
      `shouldBe`
      ["Way too many pickles",
       "Bad pickle-flange interaction detected",
       "Flange failed!"]

-- | Run tests for Homework02
testHomework02 :: IO ()
testHomework02 = do putStrLn "Homework02 Tests"
                    --grab the appropriate pieces of the official file
                    officialWhole <- readFile "res/Homework02/error.log"
                    sampleWhole   <- readFile "res/Homework02/sample.log"
                    let officialPart = unlines . take 10 $ lines officialWhole
                    hspec $ spec sampleWhole officialPart officialWhole
