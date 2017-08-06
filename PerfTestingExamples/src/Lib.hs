module Lib
    (
    myReverseAppend,
    myReverseAccum,
    ) where

-- | Reverse a list by recursing through it with append
myReverseAppend :: [Integer] -> [Integer]
myReverseAppend _ = []
myReverseAppend (x:xs) = myReverseAppend xs ++ [x]

-- | Reverse a list by recursing through it with an accumulating parameter
myReverseAccum :: [Integer] -> [Integer]
myReverseAccum nums = myReverseAccumWorker nums [] 

-- | Recursive helper for myReverseAccum
myReverseAccumWorker :: [Integer] -> [Integer] -> [Integer]
myReverseAccumWorker [] newList = newList
myReverseAccumWorker (x:xs) newList  = myReverseAccumWorker xs (x:newList)
