{-# OPTIONS_GHC -Wall #-}
module Homework02 where

import Log

-- | Parse a line of the log into the structured format
parseMessage :: String -> LogMessage
parseMessage message = LogMessage messageType 1312 "Lorem Ipsum"
  where chunks             = words message
        code               = (head . take 1) chunks
        errorLevel  :: Int
        errorLevel         = case code of
                                "E" -> (read . head . take 1 . drop 1) chunks
                                (_) -> 0
        messageType :: MessageType
        messageType = case code of
                         "E" -> Error errorLevel
                         "I" -> Info
                         "W" -> Warning
                         --TODO: how to make this exhaustive?
