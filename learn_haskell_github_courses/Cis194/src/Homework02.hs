{-# OPTIONS_GHC -Wall #-}
module Homework02 where

import Log

-- | Parse a line of the log into the structured format
parseMessage :: String -> LogMessage
parseMessage _ = LogMessage Info 9001 "Lorem Ipsum"
