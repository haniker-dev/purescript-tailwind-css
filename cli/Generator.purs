module Generator (GeneratedResult, generate) where

import Prelude

import Effect.Aff (Aff)
import Generator.Config as Config
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
  twConfig <- Config.loadTwConfig twConfigPath
  base <- Base.generate twConfig
  pure
    { tailwind: tailwind
    , base
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
