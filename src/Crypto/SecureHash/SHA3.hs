{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE Trustworthy  #-}
module Crypto.SecureHash.SHA3(sha3_512) where

import Crypto.SecureHash.SHA3.FFI
import qualified Data.ByteString as BS
import Data.ByteString (ByteString)


import Foreign.ForeignPtr       ( withForeignPtr)
import Data.ByteString.Internal (create, toForeignPtr)
import System.IO.Unsafe (unsafeDupablePerformIO)

import Foreign.Ptr
import Data.Word (Word8,Word32)



{-# INLINE withByteStringPtr #-}
withByteStringPtr :: ByteString -> Word32 -> (Ptr Word8  -> Word32 ->  Ptr Word8-> IO ()) -> IO ByteString
withByteStringPtr b resSize f =
    withForeignPtr fptr $ \ptr ->
          create (fromIntegral resSize) $ \resPtr -> f (ptr `plusPtr` off) (fromIntegral $ BS.length b) resPtr
    where (fptr, off, _) = toForeignPtr b

unsafeDoIO :: IO a -> a
unsafeDoIO = unsafeDupablePerformIO

sha3_512_IO :: BS.ByteString -> IO ByteString
sha3_512_IO bsIn = withByteStringPtr bsIn  64 c_FIPS202_SHA3_512


sha3_512 :: BS.ByteString ->  ByteString
sha3_512 = (\x -> unsafeDoIO (sha3_512_IO x))

c_FIPS202_SHA3_512 :: Ptr Word8 -> Word32 -> Ptr Word8 -> IO ()
c_FIPS202_SHA3_512 ptrIn size ptrOut =
    if size >= 1024
      then c_safe_FIPS202_SHA3_512 ptrIn size ptrOut
      else c_unsafe_FIPS202_SHA3_512 ptrIn size ptrOut

