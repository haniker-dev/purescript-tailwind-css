module Generator.Base
  ( _getBaseCssClassNames
  , generate
  ) where

import Prelude

import Data.String (joinWith)
import Data.Tuple (Tuple(..))
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Generator.Config (TwConfig)
import Generator.Utility (toFnName)

generate :: TwConfig -> Aff (Tuple String String)
generate c =
  do
    classNames <- fromEffectFnAff $ _getBaseCssClassNames c "@tailwind base;\n@tailwind components;\n@tailwind utilities;"
    pure $ Tuple (psFile classNames) (jsFile)

psFile :: Array String -> String
psFile classNames =
  joinWith "\n" $
    [ "module Tailwind.Base where"
    , "import Tailwind.Tw (Tw(..), SkipAppendable)"
    , "type Funs ="
    , """  { tw :: Tw SkipAppendable"""
    ]
      <> (toPsLine <$> classNames)
      <>
        [ """  }"""
        , "funs :: Funs"
        , "funs = _funs"
        , "foreign import _funs :: Funs"
        ]

jsFile :: String
jsFile =
  joinWith "\n" $
    [ "export function _funs() {"
    , "return {};"
    , "}"
    ]

toPsLine :: String -> String
toPsLine s =
  """  , """ <> fnName <> " :: Tw \"" <> s <> "\""
  where
  fnName = toFnName s

-- TODO Don't export this
foreign import _getBaseCssClassNames
  :: TwConfig
  -> String
  -> EffectFnAff (Array String)
