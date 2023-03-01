module Generator (GeneratedResult, generate) where

import Prelude

import Effect.Aff (Aff)
import Generator.Base as Base
import Node.Path (FilePath)

type GeneratedResult =
  { tailwind :: String
  , base :: String
  , screen :: String
  , pseudo :: String

  }

-- TODO need to generate screens
-- TODO need to generate pseudo

generate :: FilePath -> Aff GeneratedResult
generate twConfigPath = do
  _ <- Base.generate twConfigPath
  pure
    { tailwind: tailwind
    , base: base
    , screen: screen
    , pseudo: pseudo
    }

-- TODO Remove below when done
tailwind :: String
tailwind =
  """module Tailwind
  ( module Tailwind.Base
  , module Tailwind.Breakpoint
  , module Tailwind.Pseudo
  , module Theme
  ) where

import Tailwind.Base
import Tailwind.Breakpoint
import Tailwind.Pseudo
import Data.Theme as Theme """

base :: String
base =
  """module Tailwind.Base where

import Data.Theme (Theme(..), SkipAppendable)

_css :: Theme SkipAppendable
_css = Theme

my_4 :: Theme "my-4"
my_4 = Theme

mb_2 :: Theme "mb-2"
mb_2 = Theme

bg_red :: Theme "bg-red"
bg_red = Theme

relative :: Theme "relative"
relative = Theme

isolate :: Theme "isolate"
isolate = Theme

min_h_full :: Theme "min-h-full"
min_h_full = Theme

absolute :: Theme "absolute"
absolute = Theme

inset_0 :: Theme "inset-0"
inset_0 = Theme

_z_10 :: Theme "-z-10"
_z_10 = Theme

h_full :: Theme "h-full"
h_full = Theme

w_full :: Theme "w-full"
w_full = Theme

object_cover :: Theme "object-cover"
object_cover = Theme

object_top :: Theme "object-top"
object_top = Theme

mx_auto :: Theme "mx-auto"
mx_auto = Theme

max_w_7xl :: Theme "max-w-7xl"
max_w_7xl = Theme

px_6 :: Theme "px-6"
px_6 = Theme

py_32 :: Theme "py-32"
py_32 = Theme

text_center :: Theme "text-center"
text_center = Theme

py_40 :: Theme "py-40"
py_40 = Theme

px_8 :: Theme "px-8"
px_8 = Theme

font_semibold :: Theme "font-semibold"
font_semibold = Theme

leading_8 :: Theme "leading-8"
leading_8 = Theme

text_3xl :: Theme "text-3xl"
text_3xl = Theme

font_bold :: Theme "font-bold"
font_bold = Theme

tracking_tight :: Theme "tracking-tight"
tracking_tight = Theme

text_white :: Theme "text-white"
text_white = Theme

text_5xl :: Theme "text-5xl"
text_5xl = Theme

mt_4 :: Theme "mt-4"
mt_4 = Theme

text_base :: Theme "text-base"
text_base = Theme

text_white_over_70 :: Theme "text-white-over-70"
text_white_over_70 = Theme

mt_6 :: Theme "mt-6"
mt_6 = Theme"""

screen :: String
screen =
  """module Tailwind.Breakpoint where

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
lg _ = Theme"""

pseudo :: String
pseudo =
  """module Tailwind.Pseudo where

import Data.Theme (Theme(..), class MapPrefix)

hover
  :: ∀ a b
   . MapPrefix "hover:" a b
  => Theme a
  -> Theme b
hover _ = Theme"""
