module Generator.Base
  ( _getBaseCssClassNames
  , generate
  ) where

import Prelude

import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Generator.Config (TwConfig)

generate :: TwConfig -> Aff (Array String)
generate c =
  let
    inputCss = "@tailwind base;\n@tailwind components;\n@tailwind utilities;"
  in
    fromEffectFnAff $ _getBaseCssClassNames c inputCss

-- TODO Don't export this
foreign import _getBaseCssClassNames
  :: TwConfig
  -> String
  -> EffectFnAff (Array String)

