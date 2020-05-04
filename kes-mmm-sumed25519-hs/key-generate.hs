module Main where

import KES
import Data.Word
import Data.ByteArray
import Foreign.Storable
import qualified Data.ByteString as BS

newtype PublicKey = PublicKey BS.ByteString deriving Show
newtype SecretKey = SecretKey ScrubbedBytes deriving Show
newtype Seed = Seed { unSeed :: ScrubbedBytes } deriving Show

main :: IO ()
main = do
  putStrLn "test"
  seed <- createSeed
  (pub, sec) <- withByteArray (unSeed seed) $ \seed_ptr -> do
    (public, secret) <- allocRet 836 $ \secret -> do
      (_,public) <- allocRet 32 $ \public_ptr -> do
        generate seed_ptr secret public_ptr
      pure $ PublicKey public
    pure (public, SecretKey secret)
  print pub
  print sec

createSeed :: IO Seed
createSeed = do
  (_,seed) <- allocRet 32 $ \seed_ptr -> do
    mapM_ (\i -> pokeElemOff seed_ptr i ((fromIntegral i) :: Word8)) [0..31]
  pure $ Seed seed
