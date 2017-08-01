{-# OPTIONS_GHC -Wall #-}
module Lecture03 (
  mapIntList,
  exampleList,
  addOne,
  square,
  ) where
  
data IntList = Empty | Cons Int IntList
  deriving Show

mapIntList :: (Int -> Int) -> IntList -> IntList
mapIntList function (Empty) = Empty
mapIntList function (Cons int rest) = Cons (function int) (mapIntList function rest)

exampleList :: IntList
exampleList = Cons (-1) (Cons 2 (Cons (-6) Empty))

addOne :: Int -> Int
addOne x = x + 1

square :: Int -> Int
square x = x * x
