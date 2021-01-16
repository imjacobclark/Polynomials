module Lib
    ( polynomials
    ) where

import Data.List (intersperse, intercalate)

newtype Polynomial = Polynomial [Int] deriving Show

polypend :: Int -> Polynomial -> Polynomial
polypend x (Polynomial y) = Polynomial (x : y)

add :: Polynomial -> Polynomial -> Polynomial
add (Polynomial []) (Polynomial []) = Polynomial []
add (Polynomial []) ys = ys
add xs (Polynomial []) = xs
add (Polynomial (x:xs)) (Polynomial (y:ys)) = add (Polynomial((x+y):xs)) (Polynomial ys)

scale :: Int -> Polynomial -> Polynomial
scale a (Polynomial xs) = Polynomial (map (a*) xs)

multiply :: Polynomial -> Polynomial -> Polynomial
multiply (Polynomial ys) (Polynomial xs)  = foldr (\x acc -> do 
  add 
    (scale x (Polynomial ys)) (polypend 0 acc)) 
    (Polynomial []) 
    xs

monomialWithPosition :: Polynomial -> Int -> [(Int, Int)]
monomialWithPosition (Polynomial []) _ = []
monomialWithPosition (Polynomial (x:xs)) n = (x,n):monomialWithPosition (Polynomial xs) (n-1)

polynomialLength :: Polynomial -> Int
polynomialLength (Polynomial p) = length p

evaluate :: Polynomial -> Int -> Int
evaluate (Polynomial []) _ = 0
evaluate (Polynomial (p:ps)) x = p + x * evaluate (Polynomial ps) x

format :: (Eq a1, Eq a2, Num a1, Num a2, Show a1, Show a2) => (a1, a2) -> [Char]
format (0, _) = ""
format (1, 1) = "x"
format (coefficient, 1) = show coefficient ++ "x"
format (coefficient, 0) = show coefficient
format (1, exponent) = "x^" ++ show exponent
format (coefficient, exponent) = show coefficient ++ "x^" ++ show exponent

stringulate :: [[Char]] -> [Char]
stringulate = intercalate "" . intersperse " + "

polynomials :: IO ()
polynomials = do
  let p1 = Polynomial [1,2,3]
  let p2 = Polynomial [1,2,3]
  let p3 = add p1 p2
  print $ evaluate p3 5
  print . stringulate . map format $ monomialWithPosition p3 (polynomialLength p3 - 1)

-- -- https://github.com/hashanp/haskell-projects/blob/master/Polynomial.hs
-- -- http://hackage.haskell.org/package/dsp-0.2.1/docs/src/Polynomial-Basic.html
-- -- https://en.wikipedia.org/wiki/Horner%27s_method
-- -- https://www.youtube.com/watch?v=jpD_BugTR6I
