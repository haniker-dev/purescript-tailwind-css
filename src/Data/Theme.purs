module Data.Theme
  ( (~)
  , SkipAppendable
  , Theme(..)
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

data Theme :: Symbol -> Type
data Theme a = Theme

instance IsSymbol a => Show (Theme a) where
  show :: Theme a -> String
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
  => Theme a
  -> Theme b
  -> Theme c
merge _ _ = Theme

infixr 5 merge as ~

{-| Map a prefix over a symbol that is separated by spaces
eg. MapPrefix "sm:" "mt-4 px-2" produces "sm:mt-4 sm:px-2"
-}
mapPrefix
  :: ∀ p a b
   . MapPrefix p a b
  => Proxy p
  -> Theme a
  -> Theme b
mapPrefix _ _ = Theme

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

