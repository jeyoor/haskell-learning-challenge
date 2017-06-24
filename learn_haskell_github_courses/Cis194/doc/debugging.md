#Homework1

##toDigitsWorker
Forgot case for num < 0 and caused infinite recursion
Whole system got slow when running `stack test`
Was able to use an initial trace guard to notice and fix

##doubleEveryOther
Seems to be working for odd count lists
Why failing on even count?

For even count lists it's doubling the last item not second to last.
Are we starting at the wrong end?

Yep. Using ghci on some examples I could see I needed to (myReverse nums) before calling the worker.

##sumDigits

Ok, tests pass, but something is wrong.

*Main Homework01 Lecture01 Lib> sumDigits [16, 1, 2, 3, 1, 1, 1]
25
*Main Homework01 Lecture01 Lib> sumDigits [16, 1, 2, 3, 1, 1, 1, 1]
17

Updating tests
