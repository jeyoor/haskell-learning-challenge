{-# LANGUAGE ScopedTypeVariables, TemplateHaskell #-}
module Main where
import Lecture01Test   (testLecture01)
import Homework01Test  (testHomework01)
import Homework02Test  (testHomework02)
import Homework03Test  (testHomework03)


main :: IO ()
main = do testLecture01
          testHomework01
          testHomework02
          testHomework03
