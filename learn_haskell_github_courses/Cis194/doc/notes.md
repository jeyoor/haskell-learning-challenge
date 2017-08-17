#Homework1

##Hanoi

Hanoi is recursive!
It's an example of an algorithm naturally amenable to recursion.

The example is using "a" as the source and "b" as the sink ("c" is temp storage!)

##Tests

Got good feedback here
https://codereview.stackexchange.com/questions/166623/upenn-cis194-credit-card-validation-homework-1-part-1-tests

$ is for changing precedence of function application
=> is 


Code Review Stack Exchange comment below

Thanks for the reply! 

I wasn't familiar with the $ and => operators, so I added some explanation below.

$ evidently changes the precedence of function application (reduces the number of parentheses required.)

[$ operator](https://stackoverflow.com/questions/940382/haskell-difference-between-dot-and-dollar-sign)

=> is used in type signatures to specify class constraints.
[=> operator](http://learnyouahaskell.com/types-and-typeclasses#believe-the-type)

#Lecture2

##Beyond Enumerations

Guess: the type of OK is a constructor of FailableDouble

In other words, it's a function that takes a Double and returns a FailableDouble

How to test this with ghci?

*Main Homework01 Homework02 Lecture01 Lib Log> data FailableDouble = Failure | OK Double deriving Show

*Main Homework01 Homework02 Lecture01 Lib Log> :t OK
OK :: Double -> FailableDouble
*Main Homework01 Homework02 Lecture01 Lib Log> :t Failure
Failure :: FailableDouble

Yay it's true.


This is a very important point


-- Store a person's name, age, and favourite Thing.
data Person = Person String Int Thing
  deriving Show

"Notice how the type constructor and data constructor are both named Person, but they inhabit different namespaces and are different things. This idiom (giving the type and data constructor of a one-constructor type the same name) is common, but can be confusing until you get used to it.
"

Key words there being *one-constructor type*.
If it's a *one-constructor* type the type constructor and data constructor often have the same name.

##Algebraic data types in general
Type and data constructors *always* start with a Capital letter.

##Dream aside
Use IHaskell kernel to build math explorations in Jupyter
Explore different pieces of mathematics
It'd be amazing to mashup LaTeX and Haskell together for this purpose.

##Pattern-matching

An underscore _ can be used as a “wildcard pattern” which matches anything.

A pattern of the form x@pat can be used to match a value against the pattern pat, but also give the name x to the entire value being matched. For example:

Hmmm... I wonder if this could be used to greatly simplify the parse functions?

Just pattern matching stuff IF IT'S THERE????
HMMMM

##Recursive data types
Just reuse the *Type constructor* name.
This creates a recursive structure.
I *believe* this requires that the *type constructor* and *data constructor* must have separate names.

#Homework2

##parseMessage
ok so how do we get this code to handle errors properly?
I would like the code to handle errors in parsing integers 

I think the solution is to switch to readMaybe from Text.Read
But we can put this as a TODO

##whoDunIt

wow ok this is hard.

There seem to be at least 3 types of messages.

1. Chunks from Alice in Wonderland
2. Linuxy error messages
3. the actual mustardwatch failures described in whatWentWrong

I wonder if it'd be possible to filter out the Alice stuff...
but maybe that's the secret!

Hard to tell... hmm....

#Homework3

##Tail Recursion vs. Guarded Recursion

Tail Recursion in haskell requires a strict accumulating parameter to avoid profilgating thunks.

https://wiki.haskell.org/Tail_recursion

https://mail.haskell.org/pipermail/haskell-cafe/2009-March/058607.html

WOW! Ok. So tail recursion without strictness (as I was writing things) is not only wrong but can be harmful in Haskell!
It thwarts laziness.

Ergo, we use "[data] guarded recursion."
We try to hide every recursive call inside a function to preserve laziness.
Cool cool.

https://wiki.haskell.org/Performance/Accumulating_parameter
WAIT! There IS a performance gain from accumulating params!!

Dang. I guess this is a case of always measure perfor for yourself.

Time to do perf testing !!! ON HOMEWORK1

But wait! Found... an answer!

https://stackoverflow.com/questions/13042353/does-haskell-have-tail-recursive-optimization/13052612#13052612

Example 1
--tail recursive
fac :: (Integral a) => a -> a
fac x = fac' x 1 where
    fac' 1 y = y
    fac' x y = fac' (x-1) $! (x*y) 

Example 2
--normal recursive
facSlow :: (Integral a) => a -> a
facSlow 1 = 1
facSlow x = x * facSlow (x-1)



Summary

   * If you want to optimise your code, step one is to compile with -O2
   * Tail recursion is only good when there's no thunk build-up, and adding strictness usually helps to prevent it, if and where appropriate. This happens when you're building a result that is needed later on all at once.
   * Sometimes tail recursion is a bad plan and guarded recursion is a better fit, i.e. when the result you're building will be needed bit by bit, in portions. See this question about foldr and foldl for example, and test them against each other.

See also: https://wiki.haskell.org/Performance/Strictness

According to this, adding optimizations can use "strictness analysis" to check how fast your code runs



##Aside on debugging and profiling

Debugging (inspecting the state of the program) is crucial to using a programming environment effectively.
Here are some ways to accomplish this in Haskell

   * Use [Debug.Trace](https://wiki.haskell.org/Debugging#Printf_and_friends) to manually print out function parameters and intermediate values
   * Enable stack traces when an exception happens
      * Requires that profiling be enabled for the build (passing `-prof` and optionally `-fprof-auto -fprof-cafs` to GHC)
      * Requires passing `+RTS -xc` to enable the stack traces in the Haskell runtime system (RTS)
   * Set breakpoints in ghci
      * use `:break (LINE,COL)` to set a break point
      * once ghci breaks, you can use `seq` to force evalutation and `:print` to show the value of what is available
   * Use [Hood](https://ku-fpg.github.io/software/hood/) to automatically trace function parameters and intermediate values (requires rebuilding)
   * Use [Hoed](https://wiki.haskell.org/Hoed) does not require rebuilding?
Warning: Hat, Hood, and Hoed appear to have relatively few commits in the past 2+ years.


Enabling profiling in GHC builds (required for stack traces above) gives your program the capability to produce profiles when running.
The RTS can produce many types of profiles. More information is available [here](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/profiling.html).

All GHC flags are listed [here](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/flags.html#flag-reference)

In a .cabal file, GHC flags can be specified within the `ghc-options:` field of the appropriate `library` or `exectuable` section.

More information on creating packages in Cabal is [available here.](https://www.haskell.org/cabal/users-guide/developing-packages.html)

When using `stack exec`, you need to place command-line options for your program (such as `+RTS -xc` after --)

See [this link](https://github.com/commercialhaskell/stack/issues/1655) for more information.

##Benchmarking/profiling

TODO: Use this http://www.serpentine.com/criterion/tutorial.html and this https://gist.github.com/snoyberg/9b1c77b595c4adf90880213fc49f2a21

In theory we could compare all sorts of things.

In practice, let's compare several implementations of reverse!

Added bench/Profile.hs file.
However the FILE NAME can be different from the MODULE NAME.

The MODULE NAME given in the file specified as "main-is" MUST BE "module Main(main)" exactly!

Benchmarking works! (Not sure how to get profiling of the benchmark going?)


benchmarking myReverseAppend/[1..100]
time                 3.986 μs   (3.982 μs .. 3.990 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 3.992 μs   (3.988 μs .. 4.003 μs)
std dev              22.03 ns   (12.97 ns .. 37.97 ns)
             
benchmarking myReverseAppend/[1..1000]
time                 53.88 μs   (53.82 μs .. 53.95 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 53.90 μs   (53.84 μs .. 53.96 μs)
std dev              195.0 ns   (159.7 ns .. 247.6 ns)
             
benchmarking myReverseAccum/[1..100]
time                 1.877 μs   (1.870 μs .. 1.887 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 1.868 μs   (1.866 μs .. 1.873 μs)
std dev              11.43 ns   (7.056 ns .. 22.16 ns)
             
benchmarking myReverseAccum/[1..1000]
time                 19.93 μs   (19.90 μs .. 19.98 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 19.96 μs   (19.90 μs .. 20.10 μs)
std dev              270.3 ns   (90.00 ns .. 521.7 ns)


Overall it would appear that the accum with a strict accum param is faster...

Please note that this also had -O2 enabled so who knows what would happen w/o dat.

Let's try it with 10k and 100k instead!

##More info on profiling

Need to rebuild in profiling mode?
http://lambdor.net/?p=258

You can add --profile and other stack options to build in profiling mode.

However, you need to `stack clean` and `stack (build|test|bench) --profile`.
To rebuild for this purpose and redownload libs with profiling.

All libs will have to be redownloaded and rebuilt. This takes a long time.

Maybe we should use --no-library-profiling to prevent this

