{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE ViewPatterns, PatternSynonyms, RankNTypes #-}

module Homework01 (
    toDigits,
    toDigitsRev,
    myReverse,
    doubleEveryOther,
    sumDigits,
    sumList,
    sumDigitsFoldWorker,
    validate,
    checkSum,
    hanoi,
    ) where

-- | Convert a number [like 1234] into a list of individual digits [like [1, 2, 3, 4]
toDigits :: Integer -> [Integer]
toDigits num = toDigitsWorker 1 num [] 

-- | Recursive helper for toDigits.
toDigitsWorker :: Integer -> Integer -> [Integer] -> [Integer]
toDigitsWorker place num list 
  | num <=  0  = list
  | otherwise  = toDigitsWorker placeVal (num - remainder) (digit:list)
  where
    placeVal  = place*10
    remainder = num `mod` placeVal
    digit     = remainder `div` place

-- | Convert a number [like 1234] into a list of individual reversed digits [like [4, 3, 2, 1]
toDigitsRev :: Integer -> [Integer]
toDigitsRev num = myReverse (toDigits num)

-- | Reverse a list by recursing through it
myReverse :: [Integer] -> [Integer]
myReverse nums = myReverseWorker nums [] 

-- | Recursive helper for myReverse
myReverseWorker :: [Integer] -> [Integer] -> [Integer]
myReverseWorker [] newList = newList
myReverseWorker (num:rest) newList  = myReverseWorker rest (num:newList)

-- | Double every other number in the list, starting from the right
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther nums = doubleEveryOtherReverseWorker (myReverse nums) []

-- | Recursive, reversed helper for doubling every other number in the list, starting from the right
doubleEveryOtherReverseWorker :: [Integer] -> [Integer] -> [Integer]
doubleEveryOtherReverseWorker [] newList  = newList
doubleEveryOtherReverseWorker (x:[]) newList  = x:newList
doubleEveryOtherReverseWorker (x:(y:zs)) newList = doubleEveryOtherReverseWorker zs ((y * 2):x:newList)


-- | Sum the individual digits from a list of numbers produced by doubleEveryOther
sumDigits :: [Integer] -> Integer
sumDigits nums = foldr sumDigitsFoldWorker 0 nums

-- | Sum Integers from a list, using a right fold
sumList :: [Integer] -> Integer
sumList nums = foldr (+) 0 nums

-- | fold worker for sumDigits.
sumDigitsFoldWorker :: Integer -> Integer -> Integer
sumDigitsFoldWorker newNum priorNum 
  | newNum < 0   = priorNum + 0
  | newNum < 10  = priorNum + newNum
  | otherwise = priorNum + (sumList (toDigits newNum))

-- | Validate a credit card number, entered as an Integer
validate :: Integer -> Bool
validate num = (checkSum num) `mod` 10 == 0

-- | Helper to calculate the checksum value
checkSum :: Integer -> Integer
checkSum num = (sumDigits (doubleEveryOther (toDigits num)))

-- | It's an alias for the peg name
type Peg = String
-- | A move is pair of two pegs (from, to)
type Move = (Peg, Peg)
-- | This function takes the number of discs and the three peg names and returns the list of moves to solve the puzzle
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 1 start dest _ = (start, dest):[]
hanoi discs start dest storage = (hanoi (discs - 1) start storage dest) ++ (start, dest):[] ++ (hanoi (discs - 1) storage dest start)

--hanoiWorker :: Integer -> Peg -> Peg -> Peg -> [Move] -> [Move]
--hanoiWorker 1 start dest storage pastMoves = ((start, dest) : pastMoves)
--hanoiWorker discs start dest storage pastMoves = (hanoi (discs - 1) start storage dest):()
