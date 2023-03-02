module Test.Tailwind.Base where

import Prelude

import Tailwind.Base as TW
import Tailwind.Tw (Tw(..), SkipAppendable)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Tailwind.Base" do
  describe "Generated Functions" do
    it "tw" do
      show TW.tw `shouldEqual` show (Tw :: Tw SkipAppendable)

    it "mt_4" do
      show TW.mt_4 `shouldEqual` "mt-4"
