{-# LANGUAGE BangPatterns #-}

{-# OPTIONS_GHC -O2 #-}

module Main (main) where

import System.CPUTime (getCPUTime)

import Data.IntSet (IntSet)
import qualified Data.IntSet as IntSet

main :: IO ()
main = do
  print "MY SOLUTION\n\n\n" 
  test numMultiples 3 30
  test numMultiples 131 132
  test numMultiples 500 300000
  print "THE WAGNER\n\n\n" 
  test f 3 30
  test f 131 132
  test f 500 300000

test :: (Int -> Int -> Int) -> Int -> Int -> IO () 
test f !a !b = do
  start <- getCPUTime
  print (f a b)
  end   <- getCPUTime
  print $ "Needed " ++ show ((fromIntegral (end - start)) / 10^9) ++ " ms.\n"

numMultiples :: Int -> Int -> Int
numMultiples !a !b = IntSet.size (foldMap go [2..a])
  where
    go :: Int -> IntSet 
    go !x = IntSet.fromAscList [x, x+x .. b]

--- begin other thing
primes :: [Int]
primes = 2 : filter isPrime [3..]

isPrime :: Int -> Bool
isPrime n = go primes n where
  go (p:ps) n
    | p*p > n = True
    | otherwise = n `rem` p /= 0 && go ps n

divisorsWithMu :: [Int] -> [(Int, Int)]
divisorsWithMu [] = [(1,1)]
divisorsWithMu (p:ps) = rec ++ [(p*d, -mu) | (d, mu) <- rec] where
  rec = divisorsWithMu ps

f :: Int -> Int -> Int
f a b = b - sum xs
  where
    xs = [ mu * (b `div` d)
         | (d,mu) <- divisorsWithMu (takeWhile (<= a) primes)
         ]

