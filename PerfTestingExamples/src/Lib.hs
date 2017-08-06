module Lib
    (
    myReverseAppend,
    myReverseAccum,
    ) where

-- | Reverse a list by recursing through it with append
myReverseAppend :: [a] -> [a]
myReverseAppend [] = []
myReverseAppend (x:xs) = myReverseAppend xs ++ [x]

-- | Reverse a list by recursing through it with an accumulating parameter
myReverseAccum :: [a] -> [a]
myReverseAccum nums = myReverseAccumWorker nums [] 

-- | Recursive helper for myReverseAccum
myReverseAccumWorker :: [a] -> [a] -> [a]
myReverseAccumWorker [] newList = newList
myReverseAccumWorker (x:xs) newList  = myReverseAccumWorker xs $! (x:newList)
