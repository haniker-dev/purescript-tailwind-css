{-
https://github.com/dhall-lang/dhall-haskell/issues/145
We can't comment directly in the record for now

Replace sources if you want to test the generated code
sources = [ "src/**/*.purs", "cli/**/*.purs", "test/**/*.purs", "test-generated/**/*.purs" ]
-}
let sources = [ "src/**/*.purs", "cli/**/*.purs", "test/**/*.purs" ]

in  { name = "tailwind-css"
    , dependencies =
      [ "aff"
      , "argparse-basic"
      , "arrays"
      , "console"
      , "effect"
      , "either"
      , "node-buffer"
      , "node-fs"
      , "node-fs-aff"
      , "node-path"
      , "node-process"
      , "prelude"
      , "spec"
      , "spec-discovery"
      , "strings"
      , "typelevel-prelude"
      ]
    , packages = ./packages.dhall
    , sources
    , license = "MIT"
    , repository = "https://github.com/haniker-dev/purescript-tailwind-css"
    }
