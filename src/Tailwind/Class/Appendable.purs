module Tailwind.Class.Appendable
  ( SkipAppendable
  , class Appendable
  ) where

import Type.Data.Symbol (class Append) as Symbol

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

