{-# LANGUAGE PatternSynonyms #-}
module KES.Internal
    ( c_verify
    , c_generate
    , c_sign
    , c_t
    , c_update
    , pattern SIGNATURE_SIZE, pattern SECRET_KEY_SIZE, pattern PUBLIC_KEY_SIZE, pattern SEED_SIZE
    ) where

import Data.Word
import Foreign.Ptr
import Foreign.C.Types

pattern SIGNATURE_SIZE = 484
pattern SECRET_KEY_SIZE = 1220
pattern PUBLIC_KEY_SIZE = 32
pattern SEED_SIZE = 32

foreign import ccall "kes_mmm_sumed25519_publickey_verify" c_verify
    :: Ptr Word8 -- ^ public key bytes pointer
    -> Ptr Word8 -- ^ message bytes pointer
    -> CSize -- ^ message size
    -> Ptr Word8 -- ^ signature bytes pointer
    -> Bool

foreign import ccall "kes_mmm_sumed25519_secretkey_generate" c_generate
    :: Ptr Word8 -- ^ seed pointer
    -> Ptr Word8 -- ^ secret bytes buffer
    -> Ptr Word8 -- ^ public bytes buffer
    -> IO ()

foreign import ccall "kes_mmm_sumed25519_secretkey_sign" c_sign
    :: Ptr Word8 -- ^ secret bytes pointer
    -> Ptr Word8 -- ^ message bytes pointer
    -> CSize     -- ^ message size
    -> Ptr Word8 -- ^ signature buffer
    -> IO ()

foreign import ccall "kes_mmm_sumed25519_secretkey_t" c_t
    :: Ptr Word8 -- ^ secret bytes pointer
    -> Word32

foreign import ccall "kes_mmm_sumed25519_secretkey_update" c_update
    :: Ptr Word8 -- ^ secret bytes buffer
    -> IO ()
