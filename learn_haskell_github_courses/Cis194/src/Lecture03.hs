{-# OPTIONS_GHC -Wall #-}
module Lecture03 (
  mapIntList,
  exampleList,
  addOne,
  square,
  filterIntList,
  filterList,
  mapList,
  ) where
  
data IntList = Empty | Cons Int IntList
  deriving Show

mapIntList :: (Int -> Int) -> IntList -> IntList
mapIntList _ (Empty) = Empty
mapIntList function (Cons int rest) = Cons (function int) $ mapIntList function rest

exampleList :: IntList
exampleList = Cons (-1) (Cons 2 (Cons (-6) Empty))

addOne :: Int -> Int
addOne x = x + 1

square :: Int -> Int
square x = x * x

filterIntList :: (Int -> Bool) -> IntList -> IntList
filterIntList _ (Empty) = Empty
filterIntList predi (Cons int rest) = if predi int then Cons int $ filterIntList predi rest else filterIntList predi rest

data List t = E | C t (List t)

lst1 :: List Int
lst1 = C 3 (C 5 (C 2 E))

lst2 :: List Char
lst2 = C 'x' (C 'y' (C 'z' E))

lst3 :: List Bool
lst3 = C True (C False E)


filterList :: (a -> Bool) -> List a -> List a
filterList _ E = E
filterList predi (C int rest) = if predi int then C int $ filterList predi rest else filterList predi rest

mapList :: (a -> b) -> List a -> List b
mapList _ E = E
mapList function (C item rest) = C (function item) $ (mapList function rest)
