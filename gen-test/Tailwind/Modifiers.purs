module Tailwind.Modifiers where

import Tailwind.Tw (class MapPrefix, Tw(..))

sm
  :: ∀ a b
   . MapPrefix "sm:" a b
  => Tw a
  -> Tw b
sm _ = Tw

lg
  :: ∀ a b
   . MapPrefix "lg:" a b
  => Tw a
  -> Tw b
lg _ = Tw

hover
  :: ∀ a b
   . MapPrefix "hover:" a b
  => Tw a
  -> Tw b
hover _ = Tw