{- LANGUAGE Trustworthy -}
module Crypto.SecureHash.SHA3(sha3_512) where

import Crypto.SecureHash.SHA3.FFI
import qualified Data.ByteString as BS
import Data.Word (Word32)
import Foreign.C.String (CStringLen)

sha3_512_IO :: BS.ByteString -> IO ByteString
sha3_512_IO = undefined


BS.ByteString -> IO ByteString
sha3_512 = undefined


