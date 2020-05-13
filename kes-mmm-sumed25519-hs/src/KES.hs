module KES where

import KES.Internal
import Data.Word
import Foreign.Storable
import Data.ByteArray
import qualified Data.ByteString as BS

newtype PublicKey = PublicKey BS.ByteString deriving Show
newtype SecretKey = SecretKey ScrubbedBytes deriving Show
newtype Signature = Signature BS.ByteString deriving Show
newtype Seed = Seed { unSeed :: ScrubbedBytes } deriving Show

createSeed :: IO Seed
createSeed = do
  (_,seed) <- allocRet SEED_SIZE $ \seed_ptr -> do
    mapM_ (\i -> pokeElemOff seed_ptr i ((fromIntegral i) :: Word8)) [0..31]
  pure $ Seed seed

generate :: Seed -> IO (PublicKey, SecretKey)
generate  seed = do
  withByteArray (unSeed seed) $ \seed_ptr -> do
    (public, secret) <- allocRet SECRET_KEY_SIZE $ \secret -> do
      (_,public) <- allocRet PUBLIC_KEY_SIZE $ \public_ptr -> do
        c_generate seed_ptr secret public_ptr
      pure $ PublicKey public
    pure (public, SecretKey secret)

verify :: PublicKey -> BS.ByteString -> Signature -> IO Bool
verify (PublicKey pub) message (Signature sig) = do
  withByteArray pub $ \pub_ptr -> do
    withByteArray message $ \msg_ptr -> do
      withByteArray sig $ \sig_ptr -> do
        pure $ c_verify pub_ptr msg_ptr (fromIntegral $ BS.length message) sig_ptr

sign :: SecretKey -> BS.ByteString -> IO Signature
sign (SecretKey sec) message = do
  withByteArray sec $ \sec_ptr -> do
    withByteArray message $ \msg_ptr -> do
      (_, sig) <- allocRet SIGNATURE_SIZE $ \sig_ptr -> do
        c_sign sec_ptr msg_ptr (fromIntegral $ BS.length message) sig_ptr
      pure $ Signature sig

t :: SecretKey -> IO Word32
t (SecretKey sec) = do
  withByteArray sec $ \sec_ptr -> do
    pure $ c_t sec_ptr

update :: SecretKey -> IO ()
update (SecretKey sec) = do
  withByteArray sec $ \sec_ptr -> do
    c_update sec_ptr
