module Generator (GeneratedResult, generate) where

import Prelude

import Data.Array (fold)
import Effect.Aff (Aff)
import Generator.Base as Base
import Node.Path (FilePath)

type GeneratedResult =
  { base :: String
  , screen :: String
  , pseudo :: String

  }

-- TODO need to generate screens
-- TODO need to generate pseudo

generate :: FilePath -> Aff GeneratedResult
generate twConfigPath = do
  base <- Base.generate twConfigPath
  pure
    { base: fold base
    , screen: ""
    , pseudo: ""
    }
