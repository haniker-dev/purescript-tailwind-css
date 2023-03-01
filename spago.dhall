{ name = "tailwind"
, dependencies =
  [ "aff"
  , "argparse-basic"
  , "arrays"
  , "console"
  , "effect"
  , "either"
  , "maybe"
  , "node-buffer"
  , "node-fs"
  , "node-fs-aff"
  , "node-path"
  , "node-process"
  , "prelude"
  , "spec"
  , "spec-discovery"
  , "typelevel-prelude"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "cli/**/*.purs", "test/**/*.purs" ]
, license = "MIT"
, repository = "https://github.com/haniker-dev/purescript-tailwind-css"
}
