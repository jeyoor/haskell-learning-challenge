{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE ViewPatterns, PatternSynonyms, RankNTypes #-}

--note: currently experimenting by running `stack ghci` and loading this file with `:l lecture_tests.hs`
--TODO: add quickcheck tests... maybe make this a module too

module Cis194.Lecture01 (
    biggestInt,
    smallestInt,
    sumtorial,
    hailstone,
    foo,
    isEven,
    isEvenShorter,
    sumPair,
    hailstoneList,
    hailstoneSeq,
    intListLength,
    intSeqLength,
    intSeqSynonymLength,
    intSeqLongFormLength,
    sumEveryTwo,
    sumSeqEveryTwo,
    sumSeqLongFormEveryTwo,
    hailstoneLen,
    hailstoneSeqLen,
    exp_result,
    p,
    nums,
    range,
    range2,
    hello1,
    hello2,
    hello3,
    helloSame,
    hello23Same,
    emptyList,
    emptySeq,
    ex18,
    ex19,
    ex20,
    ex21,
    ex18_seq,
    ex19_seq,
    ex20_seq,
    ex21_seq,
    ) where

import Data.Char (ord)
import qualified Data.Sequence as S
import Data.Sequence (Seq, (<|), empty, singleton, viewl, ViewL(EmptyL))
import qualified Data.Foldable as DF

pattern Empty <- (viewl -> EmptyL)
pattern x :< xs <- (viewl -> x S.:< xs)

biggestInt, smallestInt :: Int
biggestInt = maxBound
smallestInt = minBound

exp_result :: Integer
base :: Integer
base = 2
exp_result = base^base^base^base

sumtorial :: Integer -> Integer
sumtorial 0 = 0
sumtorial n = n + sumtorial (n - 1)

hailstone :: Integer -> Integer
hailstone n
  | n `mod` 2 == 0 = n `div` 2
  | otherwise      = 3*n + 1

foo :: Integer -> Integer
foo 0 = 16
foo 1
  | "Haskell" > "Emptiness" = 3
  | True                    = 4
foo n
  | n < 0            = 0
  | n `mod` 17 == 2  = -43
  | otherwise        = n + 3

--guesses for function results: foo (-3) == 0, foo 0 = 16, foo 1 == 4, foo 36 == -43, foo 38 == 41
--answers:
-- *Main> [foo (-3), foo 0, foo 1, foo 36, foo 38]
-- [0,16,3,-43,41]
-- ah missed the claouse for foo 1

isEven :: Integer -> Bool
isEven n 
  | n `mod` 2 == 0 = True
  | otherwise      = False

isEvenShorter :: Integer -> Bool
isEvenShorter n = n `mod` 2 == 0

--yay for pairs
p :: (Int, Char)
p = (3, 'x')



--yay for pattern matching
sumPair :: (Int, Char) -> Int
sumPair (x, y) = x + ord y

nums, range, range2 :: [Integer]
nums   = [1,2,3,19]
range  = [1..100]
range2 = [2,4..100]

hello1 :: [Char]
hello1 = ['h', 'e', 'l', 'l', 'o']

hello2 :: String
hello2 = "hello"

hello3 :: Seq Char
hello3 = S.fromList "hello"

helloSame :: Bool
helloSame = hello1 == hello2
hello23Same :: Bool
hello23Same = hello1 == DF.toList hello3

emptyList = []
emptySeq = empty

ex18 :: [Integer]
ex18 = 1 : []
ex19 :: [Integer]
ex19 = 3 : (1 : [])
ex20 :: [Integer]
ex20 = 2 : 3 : 4 : []
ex21 :: Bool
ex21 = [2,3,4] == 2 : 3 : 4 : []

ex18_seq :: Seq Integer
ex18_seq = 1 <| empty
ex19_seq :: Seq Integer
ex19_seq = 3 <| (1 <| empty)
ex20_seq :: Seq Integer
ex20_seq = 2 <| 3 <| 4 <| empty 
ex21_seq :: Bool
ex21_seq = S.fromList [2,3,4] == 2 <| 3 <| 4 <| empty 

hailstoneList :: Integer -> [Integer]
hailstoneList 1 = [1]
hailstoneList n = n : hailstoneList (hailstone n)

hailstoneSeq :: Integer -> Seq Integer
hailstoneSeq 1 = singleton 1
hailstoneSeq n = n <| hailstoneSeq (hailstone n)


-- Compute the length of a list of Integers.
intListLength :: [Integer] -> Integer
intListLength []     = 0
intListLength (_:xs) = 1 + intListLength xs

intSeqLength :: Seq Integer -> Integer
intSeqLength (S.viewl -> S.EmptyL)     = 0
intSeqLength (S.viewl -> (_ S.:< xs))  = 1 + intSeqLength xs
intSeqLength _                         = 0

intSeqSynonymLength :: Seq Integer -> Integer
intSeqSynonymLength Empty     = 0
intSeqSynonymLength (_ :< xs) = 1 + intSeqSynonymLength xs
intSeqSynonymLength _         = 0

intSeqLongFormLength :: Seq Integer -> Integer
intSeqLongFormLength items
  | S.null items = 0
  | otherwise    = let _ S.:< xs = (S.viewl items)
                   in              1 + intSeqLength xs

sumEveryTwo :: [Integer] -> [Integer]
sumEveryTwo []         = []     -- Do nothing to the empty list
sumEveryTwo (x:[])     = [x]    -- Do nothing to lists with a single element
sumEveryTwo (x:(y:zs)) = (x + y) : sumEveryTwo zs

sumSeqEveryTwo :: Seq Integer -> Seq Integer
sumSeqEveryTwo (S.viewl -> S.EmptyL)                        = empty       -- Do nothing to the empty seq
sumSeqEveryTwo (S.viewl -> x S.:< (S.viewl -> S.EmptyL))    = x <| empty  -- Do nothing to seqs with a single element
sumSeqEveryTwo (S.viewl -> (x S.:< (S.viewl -> y S.:< zs))) = (x + y) <| sumSeqEveryTwo zs
sumSeqEveryTwo _                                            = empty

sumSeqLongFormEveryTwo :: Seq Integer -> Seq Integer
sumSeqLongFormEveryTwo items
  | S.null items = empty       -- Do nothing to the empty seq
  | otherwise    = let x S.:< xs = (S.viewl items)
                   in  if S.null xs
                         then x <| empty
                         else let y S.:< zs = (S.viewl xs)
                              in  (x + y) <| sumSeqEveryTwo zs

-- The number of hailstone steps needed to reach 1 from a starting
-- number.
hailstoneLen :: Integer -> Integer
hailstoneLen n = intListLength (hailstoneList n) - 1

hailstoneSeqLen :: Integer -> Integer
hailstoneSeqLen n = intSeqLength (hailstoneSeq n) - 1
