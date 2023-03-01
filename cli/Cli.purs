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

  Right genDir -> launchAff_ do
    Console.log "🎬 Generating CSS Functions..."
    processDir <- liftEffect $ Process.cwd
    { base, screen, pseudo } <- generate

    let writeFile' = writeFile processDir genDir
    _ <- FS.mkdir' genDir { mode: perm755, recursive: true }
    _ <- writeFile' "Base.purs" base
    _ <- writeFile' "Screen.purs" screen
    _ <- writeFile' "Pseudo.purs" pseudo

    Console.log "🏁 Completed"

writeFile :: FilePath -> FilePath -> FilePath -> String -> Aff Unit
writeFile processDir genDir fileName s = do
  fullPath <- liftEffect $ Path.resolve [ processDir, genDir ] fileName
  _ <- FS.writeTextFile UTF8 fullPath s
  Console.log $ "✅ Generated " <> Path.concat [ genDir, fileName ]

perm755 :: Perms
perm755 = Perm.mkPerms Perm.all Perm.all (Perm.read + Perm.execute)

parseArgs :: Effect (Either Arg.ArgError String)
parseArgs = do
  args <- Array.drop 2 <$> Process.argv
  pure $ Arg.parseArgs
    "purs-tailwind-css"
    "Type-safe CSS with TailwindCSS"
    ( Arg.argument [ "--output", "-o" ] "Directory for the generated CSS function"
        <* Arg.flagHelp
    )
    args
