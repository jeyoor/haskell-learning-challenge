module Main where

import Lib

main :: IO ()
main = putStrLn $ show $ myReverseAppend [1..5]
