module Tailwind.Tw
  ( (~)
  , SkipAppendable
  , Tw(..)
  , class Appendable
  , class MapPrefix
  , class MapPrefixHelper
  , mapPrefix
  , merge
  ) where

import Prelude

import Data.Symbol (class IsSymbol, reflectSymbol)
import Type.Data.Symbol (class Append, class Cons) as Symbol
import Type.Proxy (Proxy(..))

data Tw :: Symbol -> Type
data Tw a = Tw

instance IsSymbol a => Show (Tw a) where
  show :: Tw a -> String
  show _ = reflectSymbol (Proxy :: Proxy a)

type SkipAppendable :: Symbol
type SkipAppendable = "@@@"

class Appendable :: Symbol -> Symbol -> Symbol -> Constraint
class Appendable a b c | a b -> c

instance Appendable SkipAppendable b b
else instance Appendable a SkipAppendable a
else instance Appendable "" b b
else instance Appendable a "" a
else instance
  ( Symbol.Append a " " a1
  , Symbol.Append a1 b c
  ) =>
  Appendable a b c

merge
  :: forall a b c
   . Appendable a b c
  => Tw a
  -> Tw b
  -> Tw c
merge _ _ = Tw

infixr 5 merge as ~

{-| Map a prefix over a symbol that is separated by spaces
eg. MapPrefix "sm:" "mt-4 px-2" produces "sm:mt-4 sm:px-2"
-}
mapPrefix
  :: ∀ p a b
   . MapPrefix p a b
  => Proxy p
  -> Tw a
  -> Tw b
mapPrefix _ _ = Tw

class MapPrefix :: Symbol -> Symbol -> Symbol -> Constraint
class MapPrefix prefix inputLabel outputLabel | prefix inputLabel -> outputLabel

instance
  -- Set lastHead as " " to generate prefix for first element
  ( MapPrefixHelper " " prefix inputLabel outputLabel
  ) =>
  MapPrefix prefix inputLabel outputLabel

class MapPrefixHelper :: Symbol -> Symbol -> Symbol -> Symbol -> Constraint
class MapPrefixHelper lastHead prefix inputLabel outputLabel | prefix inputLabel -> outputLabel

instance MapPrefixHelper lastHead prefix "" ""

else instance
  ( Symbol.Cons h tail inputLabel
  , Symbol.Append prefix h o1
  , MapPrefixHelper h prefix tail o2
  , Symbol.Append o1 o2 outputLabel
  ) =>
  MapPrefixHelper " " prefix inputLabel outputLabel

else instance
  ( Symbol.Cons h1 tail inputLabel
  , MapPrefixHelper h1 prefix tail o1
  , Symbol.Append h1 o1 outputLabel
  ) =>
  MapPrefixHelper lastHead prefix inputLabel outputLabel

