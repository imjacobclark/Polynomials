# Polynomials

A series of functions that operate on Polynomials.

Built from the ground up with the intent to support calculating interpolating polynomials of given points.


## Definitions

_Points:_ The location on a cartesian coordinate system (a grid with an x and y axis.) Example (2,2) is a point where the location on the x and y axis respectively is 2. 

_Exponentiation:_ A power, for example, squaring a number means to raise a number by the power 2. exponentiating x to 2 is the same as raising x to the power 2.

_Coefficient:_ A coefficient is a number that is variable or constant that we multiply another number by. For example in the expression `f(x) = 2x`, `2` is the coefficient.

_Polynomial:_ A polynomial is an expression consisting a variables and coefficients, where the expression only uses addition, subtraction, multiplication and non-negative integer exponentiation of variables. For example `x^3 + 2x^2 + x + 1` is a polynomial. Once we have a polynomial, it is then possible to graph it.

_Interpolation:_ **The intersection of something** - In the context of polynomials, to "interpolate" _(verb)_ means to find the unique minimum degree polynomial passing through a set of points. For example, given the set of points `[(1,1)]`, it is clear to see there is a unique polynomial `1` that passes through these points. `[(1,1), (2,0)]` would yeild the unique polynomial of `2.0 + -1.0 * x^1`.

## Running

```shell
stack install
stack run
```

Take the example program: 

```haskell
let p1 = Polynomial [1,2,3]
let p2 = Polynomial [1,2,3]
let p1p2 = multiply p1 p2
print . stringulate . map format . monomialWithPosition p1 $ polynomialLength p1 - 1
print . stringulate . map format . monomialWithPosition p2 $ polynomialLength p2 - 1
print . stringulate . map format . monomialWithPosition p1p2 $ polynomialLength p1p2 - 1
```

The output would be:

```text
"x^2 + 2x + 3"
"x^2 + 2x + 3"
"x^4 + 4x^3 + 10x^2 + 12x + 9"
```