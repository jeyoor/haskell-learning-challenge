{-# OPTIONS_GHC -Wall #-}
module Homework03 (
    skips,
    localMaxima,
    histogram,
    ) where

import Data.List(length, sort)
--import Debug.Trace(trace)

-- | Recursively builds a list of sublists, picking every nth item
skips :: [a] -> [[a]]
skips [] = [[]]
skips l = skipsWorker 1 (replicate (length l) l)

-- | Recursively builds a list of sublists, picking every nth item
skipsWorker :: Int -> [[a]] -> [[a]]
skipsWorker num [] = []
skipsWorker num (x:xs) = (skip num x):(skipsWorker (num + 1) xs)
--skipsWorker num (x:xs) output = skipsWorker (num + 1) xs ((skip num x):output)

--TODO: replace above function with mapAccumL
--Examples working: 
--(\x y -> (x + y, y) ) 3 [1, 2, 3, 4, 5, 6]
--(24,[1,2,3,4,5,6])
--mapAccumL (\x y -> (take y x, y + 1) ) 3 ["abcd", "abcdef", "abcdefghi", "abcdefghi", "abcdefghij", "abcdefghijk"]
--mapAccumL (\x y -> (x + ord y, show x ++ [y]) ) 3 "abcdefg"
--Examples failing:
--mapAccumL (\x y -> (show x ++ y, x + 1) ) 3 ["abcdefg"]
--(703,["3a","100b","198c","297d","397e","498f","600g"])

-- | Given an index and a list, return the sublist of every indexth item
skip :: Int -> [a] -> [a]
skip base fullList  = skipWorker base 1 fullList []

-- | recursive worker for the skip function
skipWorker :: Int -> Int -> [a] -> [a] -> [a]
skipWorker _ _ [] newlist = reverse newlist
skipWorker base idx (x:xs) newlist = if idx `mod` base == 0
                                     then skipWorker base (idx + 1) xs (x:newlist)
                                     else skipWorker base (idx + 1) xs newlist

-- | filter the list down to its local maxima (one number greater than two neighbors)
localMaxima :: [Integer] -> [Integer]
--localMaxima [] | trace "localMaxima [] " False = undefined
localMaxima [] = []
--localMaxima (x:[]) | trace ("localMaxima x:[] " ++ show x) False = undefined
localMaxima (_:[]) = []
--localMaxima (x:y:[]) | trace ("localMaxima x:y:[] " ++ show x ++ " " ++ show y) False = undefined
localMaxima (_:_:[]) = []
--localMaxima (w:x:y:zs) | trace ("localMaxima w:x:y:zs" ++ show w ++ " " ++ show x ++ " " ++ show y ++ " " ++ show zs) False = undefined
-- TODO: implement this with zip3 instead?
localMaxima (w:x:y:zs) = if x >= y && x >= w
                         then x:(localMaxima (x:y:zs))
                         else    localMaxima (x:y:zs)

-- | print a stacked histogram for the number of times each digit 0-9 appears
histogram :: [Integer] -> String
histogram nums = (show $ histogramWorker nums) ++ "\n==========\n0123456789\n"

histogramIndexes :: [Integer]
histogramIndexes = [0..9]

-- | worker for building the list in ghci first
histogramWorker :: [Integer] -> [Integer]
histogramWorker nums = map (\x -> toInteger $ length $ takeWhile (\y -> y == x) (filter (== x) nums)) histogramIndexes

--here's a one-liner map (\x -> length $ takeWhile (\y -> y == x) (filter (== x) [5,1,1,1])) [0..9]
