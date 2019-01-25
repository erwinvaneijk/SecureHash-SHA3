{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP#-}
#if __GLASGOW_HASKELL__ >= 700
{-# LANGUAGE Trustworthy  #-}
#endif
{- | This module exposes the reference sha3 functions with digest sizes


-}

module Crypto.SecureHash.SHA3(sha3_512,sha3_256,sha3_228, sha3_384) where

import Crypto.SecureHash.SHA3.FFI
import qualified Data.ByteString as BS
import Data.ByteString (ByteString)


import Foreign.ForeignPtr       ( withForeignPtr)
import Data.ByteString.Internal (create, toForeignPtr)
import System.IO.Unsafe (unsafeDupablePerformIO)

import Foreign.Ptr
import Data.Word (Word8,Word64)



{-# INLINE withByteStringPtr #-}
withByteStringPtr :: ByteString -> Word64 -> (Ptr Word8  -> Word64 ->  Ptr Word8-> IO ()) -> IO ByteString
withByteStringPtr b resSize f =
    withForeignPtr fptr $ \ptr ->
          create (fromIntegral resSize) $ \resPtr -> f (ptr `plusPtr` off) (fromIntegral $ BS.length b) resPtr
    where (fptr, off, _) = toForeignPtr b

unsafeDoIO :: IO a -> a
unsafeDoIO = unsafeDupablePerformIO


{-# INLINE hoistedSha3App #-}
hoistedSha3App :: Word64 -> (Ptr Word8 -> Word64 -> Ptr Word8 -> IO ()) -> (ByteString ->  ByteString)
hoistedSha3App = \size f -> (\bsIn ->  unsafeDoIO $  withByteStringPtr bsIn  size f)

sha3_512 :: ByteString ->  ByteString
sha3_512 =  wrappedSha3 64  c_safe_FIPS202_SHA3_512 c_unsafe_FIPS202_SHA3_512

sha3_228 :: ByteString -> ByteString
sha3_228 = wrappedSha3 28 c_safe_FIPS202_SHA3_224 c_unsafe_FIPS202_SHA3_224

sha3_256 :: ByteString -> ByteString
sha3_256 = wrappedSha3 32 c_safe_FIPS202_SHA3_256 c_unsafe_FIPS202_SHA3_256

sha3_384 :: ByteString -> ByteString
sha3_384 = wrappedSha3 48 c_safe_FIPS202_SHA3_384 c_unsafe_FIPS202_SHA3_384

wrappedSha3 :: Word64 -> (Ptr Word8 -> Word64 -> Ptr Word8 -> IO ())
      -> (Ptr Word8 -> Word64 -> Ptr Word8 -> IO ())
      -> (ByteString -> ByteString)
wrappedSha3 = \resSize safeF unsafeF ->
  hoistedSha3App resSize $ \ ptrIn size ptrOut ->
  if size >= 1024
      then safeF ptrIn size ptrOut
      else unsafeF ptrIn size ptrOut


