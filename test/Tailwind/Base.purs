module Test.Tailwind.Base where

import Prelude

import Tailwind.Base as TW
import Data.Theme (Theme(..), Skip)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Tailwind.Base" do
  describe "Generated Functions" do
    it "css" do
      show TW.css `shouldEqual` show (Theme :: Theme Skip)

    it "mt_4" do
      show TW.mt_4 `shouldEqual` "mt-4"
