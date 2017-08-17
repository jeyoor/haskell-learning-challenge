module Main(main) where

import Criterion.Main
import Lib

main = defaultMain [
  bgroup "myReverseAppend" [ bench "[1..100]"   $ whnf myReverseAppend [1..100]
                           , bench "[1..1000]"  $ whnf myReverseAppend [1..1000]
                           ],
  bgroup "myReverseAccum"  [ bench "[1..100]"   $ whnf myReverseAccum  [1..100]
                           , bench "[1..1000]"  $ whnf myReverseAccum  [1..1000]
                           ]
  ]
