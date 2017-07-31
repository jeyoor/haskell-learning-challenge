{-# OPTIONS_GHC -Wall #-}
module Homework02 (
    parseMessage,
    grabSecond,
    grabThird,
    ) where

import Log

import Debug.Trace(trace)

-- | Parse a line of the log into the structured format
parseMessage :: String -> LogMessage
parseMessage message
-- Debug tracing
--  | trace ("message: " ++ (show message) ++ "code: " ++ (show code)) False = undefined
  | otherwise = LogMessage messageType timestamp errorMessage
  where chunks             = words message
        code               = grabFirst  chunks
        errorLevel  :: Int
        errorLevel         = case code of
                                "E" -> (read . grabSecond) chunks
                                (_) -> 0
        timestamp   :: Int
        timestamp          = case code of
                                "E" -> (read . grabThird) chunks
                                (_) -> (read . grabSecond) chunks
        errorMessage     :: String
        errorMessage            = case code of
                                     "E" -> fourthFollowing chunks
                                     (_) -> thirdFollowing chunks
        messageType :: MessageType
        messageType        = case code of
                                "E" -> Error errorLevel
                                "I" -> Info
                                "W" -> Warning
--TODO: how to make this exhaustive? How to do error handling?
--  1. catch parse exceptions
--  2. handle empty code, etc

--Possible experiments/exploration of Maybe approach below

-- | Get first string from a list
grabFirst :: [String] -> String
grabFirst = unwords . take 1

-- | Get second string from a list
grabSecond :: [String] -> String
grabSecond = grabFirst . drop 1

-- | Get third string from a list
grabThird :: [String] -> String
grabThird = grabFirst . drop 2

-- | Concatenate the third and following strings from a list
thirdFollowing :: [String] -> String
thirdFollowing = unwords . drop 2

-- | Concatenate the fourth and following strings from a list
fourthFollowing :: [String] -> String
fourthFollowing = unwords . drop 3
