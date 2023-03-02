module Tailwind.Pseudo where

import Tailwind.Tw (Tw(..), class MapPrefix)

hover
  :: ∀ a b
   . MapPrefix "hover:" a b
  => Tw a
  -> Tw b
hover _ = Tw