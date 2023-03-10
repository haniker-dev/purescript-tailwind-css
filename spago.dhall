{ name = "tailwind-css"
, dependencies =
  [ "aff"
  , "argparse-basic"
  , "arrays"
  , "console"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "halogen"
  , "integers"
  , "maybe"
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
, sources =
  [ "src/**/*.purs", "cli/**/*.purs", "test/**/*.purs", "gen-test/**/*.purs" ]
, license = "MIT"
, repository = "https://github.com/haniker-dev/purescript-tailwind-css"
}
