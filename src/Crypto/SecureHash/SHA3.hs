
module Crypto.SecureHash.SHA3(sha3_512) where

import Crypto.SecureHash.SHA3.FFI
import qualified Data.Bytestring as BS
import Data.Word (Word32)
import Foreign.C.String (CStringLen)

