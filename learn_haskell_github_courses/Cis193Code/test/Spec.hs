{-# LANGUAGE ScopedTypeVariables, TemplateHaskell #-}
module Main where
import Lecture01Test   (testLecture01)
import Homework01Test  (testHomework01)


main :: IO ()
main = do testLecture01
          testHomework01
