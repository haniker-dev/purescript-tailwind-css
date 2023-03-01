module Cli where

import Prelude

import Data.Array as Array
import Data.FnGenerator (generateCode)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class.Console (log)

run :: String -> Effect Unit
run dir = launchAff_ do
  log dir
  classes <- generateCode
  log $ "Classes found: " <> (show $ Array.length classes)

