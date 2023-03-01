module Cli where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Generator (generate)
import Node.Encoding (Encoding(..))
import Node.FS.Aff as FS
import Node.FS.Perms (Perms)
import Node.FS.Perms as Perm
import Node.Path (FilePath)
import Node.Path as Path

-- processDir is the current directory of the invoked cli process from `process.cwd()`
run :: FilePath -> Effect Unit
run processDir = launchAff_ do
  log "🎬 Generating CSS Functions..."
  { base, screen, pseudo } <- generate
  let writeFile' = writeFile processDir "./test-generated"
  _ <- FS.mkdir' "./test-generated" { mode: perm644, recursive: true }
  _ <- writeFile' "Base.purs" base
  _ <- writeFile' "Screen.purs" screen
  _ <- writeFile' "Pseudo.purs" pseudo
  log "🏁 Completed"

writeFile :: FilePath -> FilePath -> FilePath -> String -> Aff Unit
writeFile processDir genDir fileName s = do
  fullPath <- liftEffect $ Path.resolve [ processDir, genDir ] fileName
  _ <- FS.writeTextFile UTF8 fullPath s
  log $ "✅ Generated " <> Path.concat [ genDir, fileName ]

perm644 :: Perms
perm644 =
  (Perm.mkPerms (Perm.read + Perm.write) Perm.read Perm.read)
