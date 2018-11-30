{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE Unsafe  #-}

-- Ugly hack to workaround https://ghc.haskell.org/trac/ghc/ticket/14452
{-# OPTIONS_GHC -O0
                -fdo-lambda-eta-expansion
                -fcase-merge
                -fstrictness
                -fno-omit-interface-pragmas
                -fno-ignore-interface-pragmas #-}

{-# OPTIONS_GHC -optc-Wall -optc-O3 #-}



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


{- NOTE: CUChar or Word8 would be more precise, but I'm giving them type CCHar

-}
foreign import capi unsafe "CTS_SHA3.h CTS_FIPS202_SHA3_512"
  c_unsafe_FIPS202_SHA3_512 :: Ptr Word8 -> Word32 -> Ptr Word8 -> IO ()
foreign import capi safe "CTS_SHA3.h CTS_FIPS202_SHA3_512"
  c_safe_FIPS202_SHA3_512 :: Ptr Word8 -> Word32 -> Ptr Word8 -> IO ()

foreign import capi unsafe "CTS_SHA3.h CTS_FIPS202_SHA3_256"
  c_unsafe_FIPS202_SHA3_256 :: Ptr Word8 -> CUInt -> Ptr Word8 -> IO ()
foreign import capi safe "CTS_SHA3.h CTS_FIPS202_SHA3_256"
  c_safe_FIPS202_SHA3_256 :: Ptr Word8 -> CUInt -> Ptr Word8 -> IO ()

foreign import capi unsafe "CTS_SHA3.h CTS_FIPS202_SHA3_224"
  c_unsafe_FIPS202_SHA3_224 :: Ptr Word8 -> CUInt -> Ptr Word8 -> IO ()
foreign import capi safe "CTS_SHA3.h CTS_FIPS202_SHA3_224"
  c_safe_FIPS202_SHA3_224 :: Ptr Word8 -> CUInt -> Ptr Word8 -> IO ()


foreign import capi unsafe "CTS_SHA3.h CTS_FIPS202_SHA3_384"
  c_unsafe_FIPS202_SHA3_384 :: Ptr Word8 -> CUInt -> Ptr Word8 -> IO ()
foreign import capi safe "CTS_SHA3.h CTS_FIPS202_SHA3_384"
  c_safe_FIPS202_SHA3_384 :: Ptr Word8 -> CUInt -> Ptr Word8 -> IO ()


foreign import capi unsafe "CTS_SHA3.h CTS_FIPS202_SHAKE128"
  c_unsafe_FIPS202_SHAKE128 :: Ptr Word8 -> CUInt -> Ptr Word8 -> CUInt -> IO ()
foreign import capi safe "CTS_SHA3.h CTS_FIPS202_SHAKE128"
  c_safe_FIPS202_SHAKE128 :: Ptr Word8 -> CUInt -> Ptr Word8 -> CUInt -> IO ()


foreign import capi unsafe "CTS_SHA3.h CTS_FIPS202_SHAKE256"
  c_unsafe_FIPS202_SHAKE256 :: Ptr Word8 -> CUInt -> Ptr Word8 -> CUInt -> IO ()
foreign import capi safe "CTS_SHA3.h CTS_FIPS202_SHAKE256"
  c_safe_FIPS202_SHAKE256 :: Ptr Word8 -> CUInt -> Ptr Word8 -> CUInt -> IO ()


{-
 /Users/carter/WorkSpace/active/SecureHash-SHA3/cbits/CTS_SHA3.h: line 80, column 1:
    error:
     warning: unused function 'CTS_FIPS202_SHAKE128' [-Wunused-function]
   |
80 | static void CTS_FIPS202_SHAKE128(const unsigned char *input, unsigned int inputByteLen, unsigned char *output, int outputByteLen)
   |             ^

  /Users/carter/WorkSpace/active/SecureHash-SHA3/cbits/CTS_SHA3.h: line 88, column 1:
    error:
     warning: unused function 'CTS_FIPS202_SHAKE256' [-Wunused-function]
   |
88 | static void CTS_FIPS202_SHAKE256(const unsigned char *input, unsigned int inputByteLen, unsigned char *output, int outputByteLen)
   |             ^

  /Users/carter/WorkSpace/active/SecureHash-SHA3/cbits/CTS_SHA3.h: line 96, column 1:
    error:
     warning: unused function 'CTS_FIPS202_SHA3_224' [-Wunused-function]
   |
96 | static void CTS_FIPS202_SHA3_224(const unsigned char *input, unsigned int inputByteLen, unsigned char *output)
   |             ^

  /Users/carter/WorkSpace/active/SecureHash-SHA3/cbits/CTS_SHA3.h: line 112, column 1:
    error:
     warning: unused function 'CTS_FIPS202_SHA3_384' [-Wunused-function]
    |
112 | static void CTS_FIPS202_SHA3_384(const unsigned char *input, unsigned int inputByteLen, unsigned char *output)
    |             ^

-}