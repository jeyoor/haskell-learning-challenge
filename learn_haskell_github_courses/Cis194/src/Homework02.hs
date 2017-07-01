{-# OPTIONS_GHC -Wall #-}
module Homework02 where

import Log

-- | Parse a line of the log into the structured format
parseMessage :: String -> LogMessage
parseMessage message = LogMessage messageType 1312 "Lorem Ipsum"
  where chunks             = words message
        code               = (unwords . take 1) chunks
        errorString        = (unwords . take 1 . drop 1) chunks
        errorLevel  :: Int
        errorLevel         = case code of
                                "E" -> (read . unwords . take 1 . drop 1) chunks
                                (_) -> 0
        messageType :: MessageType
        messageType = case code of
                         "E" -> Error errorLevel
                         "I" -> Info
                         "W" -> Warning
--TODO: how to make this exhaustive? How to do error handling?

--Possible experiments/exploration of Maybe approach below

-- | Maybe retrieve first item from a list 
grabFirst :: [a] -> Maybe a
grabFirst (x:_) = Just x
grabFirst (_)   = Nothing

-- | Maybe retrieve second item from a list 
grabSecond :: [a] -> Maybe a
grabSecond (x:_:_) = Just x
grabSecond (_)     = Nothing

-- | Maybe retrieve third item from a list 
grabThird :: [a] -> Maybe a
grabThird (x:_:_:_) = Just x
grabThird (_)       = Nothing

-- | Maybe convert a String to an Int
convertInt :: Maybe String -> Maybe Int
--TODO: use safe read here
convertInt (Just a) = Just (read a)
convertInt (_)      = Nothing

-- | Create data?
handleCode :: Maybe String -> Maybe String -> Maybe String -> LogMessage
handleCode Nothing _ _           = Unknown ""
handleCode (Just code) Nothing _ = Unknown code
handleCode (Just code) _ Nothing = Unknown code
handleCode (Just code) (Just time) errorLevel = case code of
                                                 -- "E" -> LogMessage
                                                 -- "I" -> LogMessage 
                                                 -- "W" -> LogMessage
                                                  (_) -> Unknown code
