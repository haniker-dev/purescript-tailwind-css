module Generator.Base (classNames, _getBaseCssClassNames) where

import Prelude

import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Generator.Config (TwConfig)

classNames :: TwConfig -> Aff (Array String)
classNames c =
  fromEffectFnAff $ _getBaseCssClassNames c "@tailwind base;\n@tailwind components;\n@tailwind utilities;"

foreign import _getBaseCssClassNames
  :: TwConfig
  -> String
  -> EffectFnAff (Array String)

