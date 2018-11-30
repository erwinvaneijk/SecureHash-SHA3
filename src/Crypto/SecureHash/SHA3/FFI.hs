
module Crypto.SecureHash.SHA3.FFI where

import Foreign.C.Types
import Foreign.Ptr
import Data.Word

{-

/* *
  *  Function to compute SHA3-512 on the input message. The output length is fixed to 64 bytes.
  */
void CTS_FIPS202_SHA3_512(const unsigned char *input, unsigned int inputByteLen, unsigned char *output)
{
    CTS_Keccak(576, 1024, input, inputByteLen, 0x06, output, 64);
}


-}


{- NOTE: CUChar or Word

-}
foreign import ccall unsafe "CTS_FIPS202_SHA3_512"
  c_unsafe_FIPS202_SHA3_512 :: Ptr CChar -> CUInt -> Ptr Word8 -> IO ()
foreign import ccall safe "CTS_FIPS202_SHA3_512"
  c_safe_FIPS202_SHA3_512 :: Ptr CChar -> CUInt -> Ptr Word8 -> IO ()
