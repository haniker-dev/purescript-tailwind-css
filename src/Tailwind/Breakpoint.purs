{-| Auto-generated: Do not change this file manually
-}
module Tailwind.Breakpoint where

import Data.Theme (class MapPrefix, Theme(..))

sm
  :: ∀ a b
   . MapPrefix "sm:" a b
  => Theme a
  -> Theme b
sm _ = Theme

lg
  :: ∀ a b
   . MapPrefix "lg:" a b
  => Theme a
  -> Theme b
lg _ = Theme
