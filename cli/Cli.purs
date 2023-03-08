module Cli where

import Prelude

import ArgParse.Basic as Arg
import Data.Array as Array
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), fromMaybe)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console as Console
import Generator (generate)
import Node.Encoding (Encoding(..))
import Node.FS.Aff as FS
import Node.FS.Perms (Perms)
import Node.FS.Perms as Perm
import Node.Path (FilePath)
import Node.Path as Path
import Node.Process as Process

run :: Effect Unit
run = parseArgs >>= case _ of
  Left err ->
    Console.error $ Arg.printArgError err

  Right options -> launchAff_ do
    { genDir, genFile, twConfig, twInputCss } <- liftEffect $ resolvePath options

    Console.log $ "🗂 Creating output directory " <> genDir.relative
    _ <- FS.mkdir' genDir.absolute { mode: perm755, recursive: true }

    fromMaybe (pure unit) $ ((\{ relative } -> Console.log $ "📤 Input CSS File " <> relative) <$> twInputCss)

    Console.log "🎬 Generating CSS Functions"
    genCode <- generate
      { moduleName: options.moduleName
      , twConfigPath: twConfig.absolute
      , twInputCssPath: _.absolute <$> twInputCss
      }
    _ <- FS.writeTextFile UTF8 genFile.absolute genCode
    Console.log $ "✅ Generated " <> genFile.relative

    Console.log "🏁 Completed"

type ResolvedPath =
  { twConfig :: { absolute :: String, relative :: String }
  , twInputCss :: Maybe { absolute :: String, relative :: String }
  , genDir :: { absolute :: String, relative :: String }
  , genFile :: { absolute :: String, relative :: String }
  }

resolvePath :: Options -> Effect ResolvedPath
resolvePath { moduleName, twConfigPath: twConfig, outputDir: genDir, twInputCssPath: twInputCss } = do
  processDir <- Process.cwd
  twConfig' <- Path.resolve [ processDir ] twConfig
  let genDir' = Path.concat [ processDir, genDir ]
  let genFile = Path.concat [ genDir, moduleName <> ".purs" ]
  genFile' <- Path.resolve [ processDir ] genFile
  twInputCss' <-
    case twInputCss of
      Nothing -> pure Nothing
      Just twInputCss_ -> do
        twInputCss' <- Path.resolve [ processDir ] twInputCss_
        pure $ Just { absolute: twInputCss', relative: twInputCss_ }

  pure
    { twConfig: { absolute: twConfig', relative: twConfig }
    , twInputCss: twInputCss'
    , genDir: { absolute: genDir', relative: genDir }
    , genFile: { absolute: genFile', relative: genFile }
    }

perm755 :: Perms
perm755 = Perm.mkPerms Perm.all Perm.all (Perm.read + Perm.execute)

parseArgs :: Effect (Either Arg.ArgError Options)
parseArgs = do
  args <- Array.drop 2 <$> Process.argv
  pure $ Arg.parseArgs
    "purs-tailwind-css"
    "purs-tailwind-css --output ./generated-src [--config ./tailwind.config.js]"
    argParser
    args

type Options =
  { moduleName :: String
  , twConfigPath :: FilePath
  , twInputCssPath :: Maybe FilePath
  , outputDir :: FilePath
  }

argParser :: Arg.ArgParser Options
argParser =
  Arg.fromRecord
    { outputDir:
        Arg.argument [ "--output", "-o" ] "Directory for the generated CSS function"
    , twConfigPath:
        Arg.argument [ "--config", "-c" ] "Path to tailwind.config.js"
          # Arg.default "./tailwind.config.js"
    , twInputCssPath:
        Arg.argument [ "--input", "-i" ] "Path to input css file"
          # Arg.optional
    , moduleName:
        Arg.argument [ "--module-name", "-n" ] "Module name for the generated CSS function"
          # Arg.default "Tailwind"
    }
    <* Arg.flagHelp
