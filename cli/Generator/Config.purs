module Generator.Config where

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

foreign import _loadConfig
  :: FilePath
  -> EffectFnAff TwConfig

foreign import _resolveConfig
  :: TwConfig
  -> TwResolvedConfig

