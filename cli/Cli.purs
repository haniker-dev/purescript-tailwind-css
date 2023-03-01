module Cli where

import Prelude

import ArgParse.Basic as Arg
import Data.Array as Array
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
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
    { twConfigPath, outputDir } <- pure $ options
    processDir <- liftEffect $ Process.cwd
    twConfigPath' <- liftEffect $ Path.resolve [ processDir ] twConfigPath

    Console.log "🎬 Generating CSS Functions..."
    { base, screen, pseudo } <- generate twConfigPath'

    let writeFile' = writeFile processDir outputDir
    _ <- FS.mkdir' outputDir { mode: perm755, recursive: true }
    _ <- writeFile' "Base.purs" base
    _ <- writeFile' "Screen.purs" screen
    _ <- writeFile' "Pseudo.purs" pseudo

    Console.log "🏁 Completed"

writeFile :: FilePath -> FilePath -> FilePath -> String -> Aff Unit
writeFile processDir outputDir fileName s = do
  fullPath <- liftEffect $ Path.resolve [ processDir, outputDir ] fileName
  _ <- FS.writeTextFile UTF8 fullPath s
  Console.log $ "✅ Generated " <> Path.concat [ outputDir, fileName ]

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
  { twConfigPath :: FilePath
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

    }
    <* Arg.flagHelp
