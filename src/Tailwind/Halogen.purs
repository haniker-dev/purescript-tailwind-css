module Tailwind.Halogen where

import Prelude (($))

import Data.Symbol (class IsSymbol, reflectSymbol)
import Type.Prelude (Proxy(..))
import Halogen.HTML (ClassName(..), IProp)
import Halogen.HTML.Properties (class_)

{-| TODO Provide documentation and example code -}
css :: ∀ tw a r i. IsSymbol a => tw a -> IProp (class :: String | r) i
css _ = class_ $ ClassName $ reflectSymbol (Proxy :: Proxy a)
