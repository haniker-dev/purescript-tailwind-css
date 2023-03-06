module Tailwind.Class.MapPrefix
  ( class MapPrefix
  , class MapPrefixHelper
  ) where

import Type.Data.Symbol (class Append, class Cons) as Symbol

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

