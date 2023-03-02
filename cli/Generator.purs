module Generator (GeneratedResult, generate) where

import Prelude

import Effect.Aff (Aff)
import Generator.Base as Base
import Node.Path (FilePath)

type GeneratedResult =
  { tailwind :: String
  , base :: String
  , modifiers :: String
  }

-- TODO Generate tailwind main file and add the css function
-- css :: ∀ a r i. IsSymbol a => Tw a -> IProp (class :: String | r) i
-- css a = class_ $ ClassName $ show a
-- data IntegrationTarget
--   = NoTarget
--   | Halogen

-- TODO Generate screens
-- TODO Generate pseudo

generate :: FilePath -> Aff GeneratedResult
generate twConfigPath = do
  _ <- Base.generate twConfigPath
  pure
    { tailwind: tailwind
    , base: base
    , modifiers: modifiers
    }

-- TODO Remove below when done
tailwind :: String
tailwind =
  """module Tailwind
  ( module Tailwind.Base
  , module Tailwind.Modifiers
  , module Tailwind.Tw
  ) where

import Tailwind.Base
import Tailwind.Modifiers
import Tailwind.Tw"""

base :: String
base =
  """module Tailwind.Base where

import Tailwind.Tw (Tw(..), SkipAppendable)

tw :: Tw SkipAppendable
tw = Tw

my_4 :: Tw "my-4"
my_4 = Tw

mb_2 :: Tw "mb-2"
mb_2 = Tw

bg_red :: Tw "bg-red"
bg_red = Tw

relative :: Tw "relative"
relative = Tw

isolate :: Tw "isolate"
isolate = Tw

min_h_full :: Tw "min-h-full"
min_h_full = Tw

absolute :: Tw "absolute"
absolute = Tw

inset_0 :: Tw "inset-0"
inset_0 = Tw

_z_10 :: Tw "-z-10"
_z_10 = Tw

h_full :: Tw "h-full"
h_full = Tw

w_full :: Tw "w-full"
w_full = Tw

object_cover :: Tw "object-cover"
object_cover = Tw

object_top :: Tw "object-top"
object_top = Tw

mx_auto :: Tw "mx-auto"
mx_auto = Tw

max_w_7xl :: Tw "max-w-7xl"
max_w_7xl = Tw

px_6 :: Tw "px-6"
px_6 = Tw

py_32 :: Tw "py-32"
py_32 = Tw

text_center :: Tw "text-center"
text_center = Tw

py_40 :: Tw "py-40"
py_40 = Tw

px_8 :: Tw "px-8"
px_8 = Tw

font_semibold :: Tw "font-semibold"
font_semibold = Tw

leading_8 :: Tw "leading-8"
leading_8 = Tw

text_3xl :: Tw "text-3xl"
text_3xl = Tw

font_bold :: Tw "font-bold"
font_bold = Tw

tracking_tight :: Tw "tracking-tight"
tracking_tight = Tw

text_white :: Tw "text-white"
text_white = Tw

text_5xl :: Tw "text-5xl"
text_5xl = Tw

mt_4 :: Tw "mt-4"
mt_4 = Tw

text_base :: Tw "text-base"
text_base = Tw

text_white_over_70 :: Tw "text-white-over-70"
text_white_over_70 = Tw

mt_6 :: Tw "mt-6"
mt_6 = Tw"""

modifiers :: String
modifiers =
  """module Tailwind.Modifiers where

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
hover _ = Tw"""
