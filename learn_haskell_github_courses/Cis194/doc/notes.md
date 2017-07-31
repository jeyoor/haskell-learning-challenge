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
