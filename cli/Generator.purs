module Generator (generate) where

import Prelude

import Data.Array (concat)
import Data.Maybe (Maybe)
import Data.String (joinWith)
import Effect.Aff (Aff)
import Generator.Base as Base
import Generator.Config (TwResolvedConfig)
import Generator.Config as Config
import Generator.Utility (toFnName)
import Node.Path (FilePath)

-- TODO Link back to cli for Halogen or no integration
-- data IntegrationTarget
--   = NoTarget
--   | Halogen

type Input =
  { moduleName :: String
  , twConfigPath :: FilePath
  , twInputCssPath :: Maybe FilePath
  }

generate :: Input -> Aff String
generate { moduleName, twConfigPath, twInputCssPath } = do
  twConfig <- Config.loadTwConfig twConfigPath
  let resolvedTwConfig = Config.resolveTwConfig twConfig
  classes <- Base.classNames twConfig twInputCssPath
  pure $ _generate moduleName classes resolvedTwConfig

{-
  Note: 
  When we generate multiple large files and re-export in a single file
  or when we re-export using `module Tailwind (module Something...) where`,
  Purescript compiler (as of version 0.15.7) is slow in compiling and inferring on hover in IDE, etc.
  Hence, we generate a single large file as the output.
-}
_generate :: String -> Array String -> TwResolvedConfig -> String
_generate moduleName baseClassNames resolvedConfig =
  joinWith "\n" $
    [ "module " <> moduleName <> " where"

    -- Imports
    , "import Data.Show (class Show)"
    , "import Type.Prelude (Proxy(..))"
    , "import Tailwind.Class.Appendable (SkipAppendable, class Appendable)"
    , "import Tailwind.Class.MapPrefix (class MapPrefix)"

    -- Halogen integration
    , "import Data.Symbol (class IsSymbol, reflectSymbol)"
    , "import Halogen.HTML (IProp)"
    , "import Tailwind.Halogen as H"
    , "css :: ∀ tw a r i. IsSymbol a => tw a -> IProp (class :: String | r) i"
    , "css = H.css"

    -- Tw Show Instance
    , "instance IsSymbol a => Show (Tw a) where"
    , "  show :: Tw a -> String"
    , "  show _ = reflectSymbol (Proxy :: Proxy a)"

    -- Type Tw
    , "data Tw :: Symbol -> Type"
    , "data Tw a = Tw"

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
      <> (concat $ toModifierFn <$> Config.screenModifiers resolvedConfig)

      -- modifier functions
      <> (concat $ toModifierFn <$> modifierClassNames)

toBaseFn :: String -> Array String
toBaseFn s =
  [ fnName <> " :: Tw \"" <> s <> "\""
  , fnName <> " = Tw"
  ]
  where
  fnName = toFnName s

toModifierFn :: String -> Array String
toModifierFn s =
  [ fnName <> " :: ∀ a b . MapPrefix \"" <> s <> ":\" a b => Tw a -> Tw b "
  , fnName <> " _ = Tw"
  ]
  where
  fnName = toFnName s

{-
  This modifierClassNames was gotten from https://tailwindcss.com/docs/hover-focus-and-other-states#quick-reference
  This modifierClassNames ignore below classes because it was handled by Config.screenModifiers 
  "sm" , "md" , "lg" , "xl" , "2xl"
  This modifierClassNames ignore below classes because it was handled by arbitrary classes
  min-[…] max-[…] supports-[…] aria-[…] data-[…]
-}
{-
  TODO: 
    Remember to add below class names back to modifier after complete arbitrary
    Currently, we ignore those class names min-[…] max-[…] supports-[…] aria-[…] data-[…]
-}
modifierClassNames :: Array String
modifierClassNames =
  [ "hover"
  , "focus"
  , "focus-within"
  , "focus-visible"
  , "active"
  , "visited"
  , "target"
  , "first"
  , "last"
  , "only"
  , "odd"
  , "even"
  , "first-of-type"
  , "last-of-type"
  , "only-of-type"
  , "empty"
  , "disabled"
  , "enabled"
  , "checked"
  , "indeterminate"
  , "default"
  , "required"
  , "valid"
  , "invalid"
  , "in-range"
  , "out-of-range"
  , "placeholder-shown"
  , "autofill"
  , "read-only"
  , "before"
  , "after"
  , "first-letter"
  , "first-line"
  , "marker"
  , "selection"
  , "file"
  , "backdrop"
  , "placeholder"
  , "max-sm"
  , "max-md"
  , "max-lg"
  , "max-xl"
  , "max-2xl"
  , "dark"
  , "portrait"
  , "landscape"
  , "motion-safe"
  , "motion-reduce"
  , "contrast-more"
  , "contrast-less"
  , "print"
  , "aria-checked"
  , "aria-disabled"
  , "aria-expanded"
  , "aria-hidden"
  , "aria-pressed"
  , "aria-readonly"
  , "aria-required"
  , "aria-selected"
  , "rtl"
  , "ltr"
  , "open"
  ]
