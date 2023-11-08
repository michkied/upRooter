# upRooter
Matlab function that numerically finds multiple roots of a function.

## Usage
`rts = upRooter(fun)`  
Takes in a function handle *fun*, and returns found roots *rts* as a vertical vector
    
`rts = upRooter(fun, initSize, ratio, seqLength, accuracy, iterLimit)`  
Runs the root finding algorithm with custom parameters (see below)

**Default arguments:**  
initSize = 5e-010  
ratio = 1.0000555  
seqLength = 950000  
accuracy = eps()*1000  
iterLimit = 100
  
## Algorithm
To calculate the roots, upRooter uses the following algorithm:
1.  Generate a vector of the first seqLength elements of a geometric
    series (with initial size = initSize and common ratio = ratio).
    Then concatenate this vector with its negative, flipped copy.
2.  In the resulting vector find such pairs of neighbouring points,
    that values of fun in these points have opposite signs (bisection
    requirement).
3.  Run bisection with found pairs of boundary points, given accuracy
    and iterLimit parameters
