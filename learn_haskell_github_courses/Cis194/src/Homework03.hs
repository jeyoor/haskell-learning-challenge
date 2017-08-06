{-# OPTIONS_GHC -Wall #-}
module Homework03 (
    skips,
    localMaxima,
    ) where

import Data.List(length)

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


localMaxima :: [Integer] -> [Integer]
localMaxima l = l
