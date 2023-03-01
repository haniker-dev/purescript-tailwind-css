module Test.Data.FnGenerator where

import Prelude

import Data.FnGenerator (_getClasses)
import Effect.Aff.Compat (fromEffectFnAff)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "FnGenerator" do
  describe "_getClasses" do
    it "generate classes" do
      r1 <- fromEffectFnAff $ _getClasses configPath classSelector
      r2 <- fromEffectFnAff $ _getClasses configPath attributeSelector
      r3 <- fromEffectFnAff $ _getClasses configPath pseudoSelector

      r1 `shouldEqual` classes
      r2 `shouldEqual` classes
      r3 `shouldEqual` classes

configPath :: String
configPath = "./tailwind.config.js"

classes :: Array String
classes =
  [ "apple"
  , "lemon"
  , "kiwi"
  , "banana"
  , "cherry"
  ]

classSelector :: String
classSelector = ".apple{} .lemon.kiwi{} .banana .cherry{}"

attributeSelector :: String
attributeSelector = ".apple[for=\"email\"]{} .lemon[value^=\"Go\"]{} .kiwi[src$=\".png\"]{} .banana[title~=create]{} .cherry[lang|=nl]{}"

pseudoSelector :: String
pseudoSelector = ".apple:active{} .lemon::after{} .kiwi:in-range{} .banana:nth-child(2){} .cherry:lang(fr){}"
