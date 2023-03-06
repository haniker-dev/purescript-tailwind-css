module Generator (generate) where

import Prelude

import Effect.Aff (Aff)
import Data.Array (concat)
import Data.String (joinWith)
import Generator.Config as Config
import Generator.Base as Base
import Generator.Utility (toFnName)
import Node.Path (FilePath)

-- TODO Generate tailwind main file and add the css function
-- css :: ∀ a r i. IsSymbol a => Tw a -> IProp (class :: String | r) i
-- css a = class_ $ ClassName $ show a
-- data IntegrationTarget
--   = NoTarget
--   | Halogen

-- TODO Generate screens
-- TODO Generate pseudo

generate :: FilePath -> Aff String
generate twConfigPath = do
  twConfig <- Config.loadTwConfig twConfigPath
  classes <- Base.classNames twConfig
  pure $ _generate classes

_generate :: Array String -> String
_generate baseClassNames =
  joinWith "\n" $
    [ "module Tailwind where"
    -- Imports
    , "import Tailwind.Tw"
    , "import Tailwind.Tw as Export"

    -- Re-export type and operator
    , "type Tw a = Export.Tw a"
    , "infixr 5 Export.merge as ~"

    -- function tw
    , "tw :: Tw SkipAppendable"
    , "tw = Tw"
    ]
      -- base functions
      <> (concat $ toFn <$> baseClassNames)
      <>
        -- screen functions
        [ "sm :: ∀ a b . MapPrefix \"sm:\" a b => Tw a -> Tw b"
        , "sm _ = Tw"
        , "lg :: ∀ a b . MapPrefix \"lg:\" a b => Tw a -> Tw b"
        , "lg _ = Tw"
        ]
      <>
        -- modifier functions
        [ "hover :: ∀ a b . MapPrefix \"hover:\" a b => Tw a -> Tw b"
        , "hover _ = Tw"
        ]

toFn :: String -> Array String
toFn s =
  [ fnName <> " :: Tw \"" <> s <> "\""
  , fnName <> " = Tw"
  ]
  where
  fnName = toFnName s
