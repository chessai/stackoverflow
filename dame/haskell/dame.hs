{-# LANGUAGE BangPatterns #-}

module Main (main) where

import Data.Bits ((.&.), (.|.), shiftR, shift)
import qualified Data.List as List
import Data.Vector.Unboxed (Vector)
import qualified Data.Vector.Unboxed as Vector
import Data.Word (Word64)
import Prelude hiding (max, sum)
import System.CPUTime (getCPUTime)

-- The Damenproblem.
-- Wiki: https://de.wikipedia.org/wiki/Damenproblem
main :: IO ()
main = do
  start <- getCPUTime
  print $ dame 14
  end <- getCPUTime
  putStrLn $ id $ "Needed " ++ (show ((fromIntegral (end - start)) / (10^9))) ++ " ms"

data BitState = BitState !Word64 !Word64 !Word64
--type BitState = (Word64, Word64, Word64)

bmap :: (Word64 -> Word64) -> BitState -> BitState
bmap f (BitState x y z) = BitState (f x) (f y) (f z)
{-# INLINE bmap #-}

bfold :: (Word64 -> Word64 -> Word64) -> BitState -> Word64
bfold f (BitState x y z) = x `f` y `f` z 
{-# INLINE bfold #-}

singleton :: Word64 -> BitState
singleton !x = BitState x x x
{-# INLINE singleton #-}

dame :: Int -> Int
dame !x = sumWith fn row
  where
    fn !x' = recur (x - 2) $ nextState $ singleton x'
    recur !depth !state = sumWith (getPossible depth (getStateVal state) state) row
    getPossible !depth !stateVal !state !bit
      | (bit .&. stateVal) > 0 = 0
      | depth == 0 = 1 
      | otherwise = recur (depth - 1) (nextState (addBitToState bit state))
    !row = Vector.iterateN x moveLeft 1

sumWith :: (Vector.Unbox a, Vector.Unbox b, Num b) => (a -> b) -> Vector a -> b
sumWith f as = Vector.sum $ Vector.map f as
{-# INLINE sumWith #-}

getStateVal :: BitState -> Word64
getStateVal !b = bfold (.|.) b

addBitToState :: Word64 -> BitState -> BitState
addBitToState !l !b = bmap (.|. l) b

nextState :: BitState -> BitState
nextState !(BitState l r c) = BitState (moveLeft l) (moveRight r) c

moveRight :: Word64 -> Word64
moveRight !x = shiftR x 1
{-# INLINE moveRight #-}

moveLeft :: Word64 -> Word64
moveLeft !x = shift x 1
{-# INLINE moveLeft #-}
