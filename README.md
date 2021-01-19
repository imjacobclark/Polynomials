# Polynomials
Polynomial fun in Haskell.

Currently supports basic operations on Polynomials, from formatting, scaling, addition, multiplication and evaluation. Eventually I plan on building a Shamir's Secret Sharing program ontop of these building blocks.

## Running

###
stack install
stack run
###

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