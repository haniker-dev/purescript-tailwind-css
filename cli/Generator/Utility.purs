module Generator.Utility
  ( toFnName
  ) where

import Prelude

import Data.String (Pattern(..), Replacement(..), replaceAll)

toFnName :: String -> String
toFnName s =
  replaceAll (Pattern "/") (Replacement "_over_") s
    # replaceAll (Pattern "-") (Replacement "_")

