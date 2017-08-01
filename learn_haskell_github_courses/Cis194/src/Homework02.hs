{-# OPTIONS_GHC -Wall #-}
module Homework02 (
    grabNthWord,
    grabNthAndFollowingWords,
    parseMessage,
    parse,
    insert,
    build,
    inOrder,
    ) where

import Log

-- | Get nth word from a list of strings
grabNthWord :: Int -> [String] -> String
grabNthWord num = unwords . take 1 . drop (num - 1)

-- | Concatenate the nth and following strings from a list
grabNthAndFollowingWords :: Int -> [String] -> String
grabNthAndFollowingWords num = unwords . drop (num - 1)

-- | Parse a line of the log into the structured format
parseMessage :: String -> LogMessage
parseMessage message = case code of
                          "E" -> parseValidMessage code chunks 
                          "W" -> parseValidMessage code chunks 
                          "I" -> parseValidMessage code chunks 
                          (_) -> parseInvalidMessage message
  where chunks             = words message
        code               = grabNthWord 1 chunks
-- | Parse an improperly formatted message into the unknown format
parseInvalidMessage :: String -> LogMessage
parseInvalidMessage message = Unknown message
-- | Parse a properly formatted line of the log into the structured format
parseValidMessage :: String -> [String] -> LogMessage
parseValidMessage code chunks = LogMessage messageType timestamp errorMessage
  where errorLevel  :: Int
        --TODO: switch to Text.Read.readMaybe and handle issues here
        errorLevel         = case code of
                                "E" -> (read . grabNthWord 2) chunks
                                (_) -> 0
        timestamp   :: Int
        timestamp          = case code of
                                "E" -> (read . grabNthWord 3) chunks
                                (_) -> (read . grabNthWord 2) chunks
        errorMessage     :: String
        errorMessage            = case code of
                                     "E" -> grabNthAndFollowingWords 4 chunks
                                     (_) -> grabNthAndFollowingWords 3 chunks
        messageType :: MessageType
        messageType        = case code of
                                "E" -> Error errorLevel
                                "I" -> Info
                                "W" -> Warning

-- | Parse an entire log file into a list of log messages
parse :: String -> [LogMessage]
parse file = map parseMessage $ lines file

-- | Insert a log message into a given tree
insert :: LogMessage -> MessageTree -> MessageTree
insert (LogMessage messageType timestamp errorMessage) Leaf = Node Leaf (LogMessage messageType timestamp errorMessage) Leaf
insert newMessage@(LogMessage messageType timestamp errorMessage) tree@(Node left existingMsg@(LogMessage _ existingTime _) right) = if timestamp <= existingTime then Node (insert newMessage left) existingMsg right else Node left existingMsg $ insert newMessage right
insert _ originalTree = originalTree

-- | Build an entire tree from a list of log messages
build :: [LogMessage] -> MessageTree
build messages = buildWorker messages Leaf

-- | Recursive worker for building a sorted tree
buildWorker :: [LogMessage] -> MessageTree -> MessageTree
buildWorker [] tree = tree
buildWorker (message:messages) tree = buildWorker messages $ insert message tree

-- | Perform an inOrder traversal to produce a sorted list of log messages
inOrder :: MessageTree -> [LogMessage]
inOrder tree = inOrderWorker tree []

-- | Recursive worker for performing the sorted list of log messages
inOrderWorker :: MessageTree -> [LogMessage] -> [LogMessage]
inOrderWorker Leaf list = list
inOrderWorker (Node left message right) list = inOrderWorker left (message:(inOrderWorker right list))
