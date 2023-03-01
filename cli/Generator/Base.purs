module Generator.Base
  ( CodeGenInput
  , _getBaseCssClassNames
  , generate
  ) where

import Prelude

import Data.Maybe (Maybe(..), fromMaybe)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)

type CodeGenInput =
  { dir :: Maybe String
  , moduleName :: Maybe String
  , configPath :: String
  }

type DefaultCodeGenInput =
  { dir :: String
  , moduleName :: String
  , configPath :: String
  }

-- TODO need to generate screens

generate :: Aff (Array String)
generate =
  let
    input =
      { dir: fromMaybe "./gen" Nothing
      , moduleName: fromMaybe "Tailwind" Nothing
      , configPath: "./tailwind.config.js"
      }
    inputCss = "@tailwind base;\n@tailwind components;\n@tailwind utilities;"
  in
    fromEffectFnAff $ _getBaseCssClassNames input.configPath inputCss

-- TODO Don't export this
foreign import _getBaseCssClassNames
  :: String
  -> String
  -> EffectFnAff (Array String)

