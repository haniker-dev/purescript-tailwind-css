module Generator.Base (classNames, _getBaseCssClassNames) where

import Prelude

import Data.Maybe (Maybe, fromMaybe)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Effect.Class (liftEffect)
import Generator.Config (TwConfig)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)
import Node.Path (FilePath)

classNames :: TwConfig -> Maybe FilePath -> Aff (Array String)
classNames c twInputCssPath = do
  inputCss <-
    fromMaybe
      (pure "@tailwind base;\n@tailwind components;\n@tailwind utilities;")
      $ ((\path -> liftEffect $ readTextFile UTF8 path) <$> twInputCssPath)
  fromEffectFnAff $ _getBaseCssClassNames c inputCss

foreign import _getBaseCssClassNames
  :: TwConfig
  -> String
  -> EffectFnAff (Array String)

