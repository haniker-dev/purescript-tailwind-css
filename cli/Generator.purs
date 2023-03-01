module Generator (GeneratedResult, generate) where

import Prelude

import Effect.Aff (Aff)

type GeneratedResult =
  { base :: String
  , screen :: String
  , pseudo :: String

  }

generate :: Aff GeneratedResult
generate =
  pure
    { base: ""
    , screen: ""
    , pseudo: ""
    }
