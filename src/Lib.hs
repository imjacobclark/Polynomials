module Lib
    ( polynomials
    ) where

import Data.List (intersperse, intercalate)

newtype Polynomial = Polynomial [Int] deriving Show
newtype Point = Point (Int, Int) deriving Show

polypend :: Int -> Polynomial -> Polynomial
polypend x (Polynomial y) = Polynomial (x : y)

add :: Polynomial -> Polynomial -> Polynomial
add (Polynomial []) ys = ys
add xs (Polynomial []) = xs
add (Polynomial (x:xs)) (Polynomial (y:ys)) = polypend (x+y) (add (Polynomial xs) (Polynomial ys))

scale :: Int -> Polynomial -> Polynomial
scale a (Polynomial xs) = Polynomial (map (a*) xs)

multiply :: Polynomial -> Polynomial -> Polynomial
multiply (Polynomial ys) (Polynomial xs) = foldr 
  (\x acc -> add (scale x (Polynomial ys)) (polypend 0 acc))
  (Polynomial []) 
  xs

monomialWithPosition :: Polynomial -> Int -> [Point]
monomialWithPosition (Polynomial []) _ = []
monomialWithPosition (Polynomial (x:xs)) n = Point (x,n) : monomialWithPosition (Polynomial xs) (n-1)

polynomialLength :: Polynomial -> Int
polynomialLength (Polynomial p) = length p

evaluate :: Polynomial -> Int -> Int
evaluate (Polynomial []) _ = 0
evaluate (Polynomial (p:ps)) x = p + x * evaluate (Polynomial ps) x

format :: Point -> [Char]
format (Point (0, _)) = ""
format (Point (1, 1)) = "x"
format (Point (coefficient, 1)) = show coefficient ++ "x"
format (Point (coefficient, 0)) = show coefficient
format (Point (1, exponent)) = "x^" ++ show exponent
format (Point (coefficient, exponent)) = show coefficient ++ "x^" ++ show exponent

stringulate :: [[Char]] -> [Char]
stringulate = intercalate "" . intersperse " + "

sigma :: Polynomial -> [Point] -> Int -> Int -> Int -> Int -> Polynomial
sigma term points xi yi j i 
  | length points == j = term
  | j == i = sigma term points xi yi (j+1) i
  | otherwise = let 
    Point (xj, _) = points !! j
      in sigma (multiply term (Polynomial [ -xj `div` (xi - xj), 1 `div` (xi - xj) ])) points xi yi (j+1) i 

polynomials :: IO ()
polynomials = do
  let p1 = Polynomial [1,2,3]
  let p2 = Polynomial [1,2,3]
  let p3 = add (Polynomial [1,2,3]) (Polynomial [1,2,3])

  print . stringulate . map format . monomialWithPosition p1 $ polynomialLength p1 - 1
  print . stringulate . map format . monomialWithPosition p2 $ polynomialLength p2 - 1
  print . stringulate . map format . monomialWithPosition (multiply p1 p2) $ polynomialLength (multiply p1 p2) - 1

  let s = sigma (Polynomial [1]) [Point (1, 1)] 1 1 0 0
  print . stringulate . map format . monomialWithPosition s $ polynomialLength s - 1
  


-- -- https://github.com/hashanp/haskell-projects/blob/master/Polynomial.hs
-- -- http://hackage.haskell.org/package/dsp-0.2.1/docs/src/Polynomial-Basic.html
-- -- https://en.wikipedia.org/wiki/Horner%27s_method
-- -- https://www.youtube.com/watch?v=jpD_BugTR6I

