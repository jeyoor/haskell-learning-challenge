{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE ViewPatterns, PatternSynonyms, RankNTypes #-}

module Homework01 (
    toDigits,
    toDigitsRev,
    ) where

-- | Convert a number [like 1234] into a list of individual digits [like [1, 2, 3, 4]
toDigits :: Integer -> [Integer]
toDigits num = toDigitsWorker [] num 1

-- | Recursive helper for toDigits.
toDigitsWorker :: [Integer] -> Integer -> Integer -> [Integer]
toDigitsWorker list num place
  | num == 0   = list
  | otherwise  = toDigitsWorker digit:list (num - remainder) place*10
  where
    remainder = num `mod` (place*10)
    digit     = remainder / place

-- | Convert a number [like 1234] into a list of individual reversed digits [like [4, 3, 2, 1]
toDigitsRev :: Integer -> [Integer]
toDigitsRev num = [num]
