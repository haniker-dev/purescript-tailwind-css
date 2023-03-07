module Generator.Utility
  ( toFnName
  ) where

import Prelude

import Data.Int (fromString)
import Data.Maybe (Maybe(..), isJust)
import Data.String (Pattern(..), Replacement(..), replaceAll, singleton, uncons)

toFnName :: String -> String
toFnName s =
  (if startWithInt s then "_" <> s else s)
    # replaceAll (Pattern "-") (Replacement "_")
    # replaceAll (Pattern ".") (Replacement "_dot_")
    # replaceAll (Pattern "/") (Replacement "_over_")

startWithInt :: String -> Boolean
startWithInt s =
  case uncons s of
    Nothing -> false
    Just { head } -> isJust $ fromString $ singleton head
