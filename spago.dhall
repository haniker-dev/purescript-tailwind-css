{ name = "tailwind"
, dependencies =
  [ "aff"
  , "console"
  , "effect"
  , "maybe"
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
