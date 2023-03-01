module Generator.Base
  ( _getBaseCssClassNames
  , generate
  ) where

import Prelude

import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Node.Path (FilePath)

generate :: FilePath -> Aff (Array String)
generate twConfigPath =
  let
    inputCss = "@tailwind base;\n@tailwind components;\n@tailwind utilities;"
  in
    fromEffectFnAff $ _getBaseCssClassNames twConfigPath inputCss

-- TODO Don't export this
foreign import _getBaseCssClassNames
  :: String
  -> String
  -> EffectFnAff (Array String)

