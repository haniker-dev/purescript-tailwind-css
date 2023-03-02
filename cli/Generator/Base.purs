module Generator.Base
  ( _getBaseCssClassNames
  , generate
  ) where

import Prelude

import Data.Array (concat)
import Data.String (joinWith)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Generator.Config (TwConfig)
import Generator.Utility (toFnName)

generate :: TwConfig -> Aff String
generate c =
  do
    classNames <- fromEffectFnAff $ _getBaseCssClassNames c "@tailwind base;\n@tailwind components;\n@tailwind utilities;"
    pure $ file classNames

file :: Array String -> String
file classNames =
  joinWith "\n" $
    [ "module Tailwind.Base where"
    , "import Tailwind.Tw (Tw(..), SkipAppendable)"
    , "tw :: Tw SkipAppendable"
    , "tw = Tw"
    ]
      <> (concat $ toFn <$> classNames)

toFn :: String -> Array String
toFn s =
  [ fnName <> " :: Tw \"" <> s <> "\""
  , fnName <> " = Tw"
  ]
  where
  fnName = toFnName s

-- TODO Don't export this
foreign import _getBaseCssClassNames
  :: TwConfig
  -> String
  -> EffectFnAff (Array String)

