{-# OPTIONS_GHC -Wall #-}
module Homework02 (
    parseMessage,
    grabNthWord,
    grabNthAndFollowingWords,
    ) where

import Log

import Debug.Trace(trace)

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
parseValidMessage code chunks
-- Debug tracing
--  | trace ("message: " ++ (show message) ++ "code: " ++ (show code)) False = undefined
  | otherwise = LogMessage messageType timestamp errorMessage
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
