{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE ViewPatterns, PatternSynonyms, RankNTypes #-}

module Homework01 (
    toDigits,
    toDigitsRev,
    myReverse
    ) where

-- | Convert a number [like 1234] into a list of individual digits [like [1, 2, 3, 4]
toDigits :: Integer -> [Integer]
toDigits num = toDigitsWorker [] num 1

-- | Recursive helper for toDigits.
toDigitsWorker :: [Integer] -> Integer -> Integer -> [Integer]
toDigitsWorker list num place
  -- debug tracing
  -- | trace ("toDigitsWorker list " ++ show list ++ " num " ++ show num ++ " place " ++ show place) False = undefined
  | num <  0   = []
  | num == 0   = list
  | otherwise  = toDigitsWorker (digit:list) (num - remainder) placeVal
  where
    placeVal  = place*10
    remainder = num `mod` placeVal
    digit     = remainder `div` place

-- | Convert a number [like 1234] into a list of individual reversed digits [like [4, 3, 2, 1]
toDigitsRev :: Integer -> [Integer]
toDigitsRev num = myReverse (toDigits num)

-- | Reverse a list by recursing through it
myReverse :: [Integer] -> [Integer]
myReverse nums = myReverseWorker [] nums

-- | Recursive helper for myReverse
myReverseWorker :: [Integer] -> [Integer] -> [Integer]
myReverseWorker newList [] = newList
myReverseWorker newList (num:rest) = myReverseWorker (num:newList) rest
