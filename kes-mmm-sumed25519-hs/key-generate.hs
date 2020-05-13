{-# LANGUAGE OverloadedStrings #-}

module Main where

import KES
import Data.Word
import Data.ByteArray
import Foreign.Storable
import qualified Data.ByteString as BS

main :: IO ()
main = do
  putStrLn "test"
  seed <- createSeed
  (pub, sec) <- generate seed
  print pub
  print sec
  sig <- sign sec "hello world"
  print sig
  valid <- verify pub "hello world" sig
  print valid
  t_val <- t sec
  print t_val
