module Generator.Config
  ( TwConfig
  , TwResolvedConfig
  , loadTwConfig
  , resolveTwConfig
  , screenModifiers
  ) where

import Prelude

import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Node.Path (FilePath)

type TwConfig = Type
type TwResolvedConfig = Type

loadTwConfig :: FilePath -> Aff TwConfig
loadTwConfig twConfigPath =
  fromEffectFnAff $ _loadConfig twConfigPath

resolveTwConfig :: TwConfig -> TwResolvedConfig
resolveTwConfig c = _resolveConfig c

screenModifiers :: TwResolvedConfig -> Array String
screenModifiers rc = _screenModifiers rc

foreign import _loadConfig
  :: FilePath
  -> EffectFnAff TwConfig

foreign import _resolveConfig
  :: TwConfig
  -> TwResolvedConfig

foreign import _screenModifiers
  :: TwResolvedConfig
  -> Array String
