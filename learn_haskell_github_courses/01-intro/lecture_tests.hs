--note: currently experimenting by running `stack ghci` and loading this file with `:l lecture_tests.hs`
--TODO: add quickcheck tests... maybe make this a module too
import Data.Char (ord)
import qualified Data.Sequence as DS
import qualified Data.Foldable as DF

biggestInt, smallestInt :: Int
biggestInt = maxBound
smallestInt = minBound

n :: Integer
n = 2^2^2^2

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

hello3 :: DS.Seq Char
hello3 = DS.fromList "hello"


helloSame = hello1 == hello2
hello23Same = hello1 == DF.toList hello3
