module Cli where

import Prelude

import Effect (Effect)
import Effect.Console (log)

run :: String -> Effect Unit
run dir = do
  log dir

