module Test.Helper where

import Data.Symbol (class IsSymbol, reflectSymbol)
import Type.Prelude (Proxy(..))

print :: ∀ f a. IsSymbol a => f a -> String
print _ = reflectSymbol (Proxy :: Proxy a)
