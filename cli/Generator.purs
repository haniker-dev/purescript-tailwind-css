module Generator (generate) where

import Prelude

import Data.Array (concat)
import Data.String (joinWith)
import Effect.Aff (Aff)
import Generator.Base as Base
import Generator.Config (TwResolvedConfig)
import Generator.Config as Config
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
  let resolvedTwConfig = Config.resolveTwConfig twConfig
  classes <- Base.classNames twConfig
  pure $ _generate classes resolvedTwConfig

{-
  Note: 
  When we generate multiple large files and re-export in a single file
  or when we re-export using `module Tailwind (module Something...) where`,
  Purescript compiler (as of version 0.15.7) is slow in compiling and inferring on hover in IDE, etc.
  Hence, we generate a single large file as the output.
-}
_generate :: Array String -> TwResolvedConfig -> String
_generate baseClassNames resolvedConfig =
  joinWith "\n" $
    [ "module Tailwind where"

    -- Imports
    , "import Data.Show (class Show)"
    , "import Data.Symbol (class IsSymbol, reflectSymbol)"
    , "import Type.Prelude (Proxy(..))"
    , "import Tailwind.Class.Appendable (SkipAppendable, class Appendable)"
    , "import Tailwind.Class.MapPrefix (class MapPrefix)"

    -- Type Tw
    , "data Tw :: Symbol -> Type"
    , "data Tw a = Tw"

    -- Tw Show Instance
    , "instance IsSymbol a => Show (Tw a) where"
    , "  show :: Tw a -> String"
    , "  show _ = reflectSymbol (Proxy :: Proxy a)"

    -- Merge Tw types
    , "merge :: forall a b c. Appendable a b c => Tw a -> Tw b -> Tw c"
    , "merge _ _ = Tw"
    , "infixr 5 merge as ~"

    -- Sugar-syntax tw
    , "tw :: Tw SkipAppendable"
    , "tw = Tw"
    ]
      -- base functions
      <> (concat $ toBaseFn <$> baseClassNames)

      -- screen functions
      <> (concat $ toScreenModifierFn <$> Config.screenModifiers resolvedConfig)
      <>
        -- modifier functions
        [ "hover :: ∀ a b . MapPrefix \"hover:\" a b => Tw a -> Tw b"
        , "hover _ = Tw"
        ]

toBaseFn :: String -> Array String
toBaseFn s =
  [ fnName <> " :: Tw \"" <> s <> "\""
  , fnName <> " = Tw"
  ]
  where
  fnName = toFnName s

toScreenModifierFn :: String -> Array String
toScreenModifierFn s =
  [ fnName <> " :: ∀ a b . MapPrefix \"" <> s <> ":\" a b => Tw a -> Tw b"
  , fnName <> " = Tw"
  ]
  where
  fnName = toFnName s
