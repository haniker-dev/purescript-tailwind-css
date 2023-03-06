module Test.Tailwind where

import Prelude

import Tailwind (Tw(..), hover, mt_4, sm, tw)
import Tailwind.Class.Appendable (SkipAppendable)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Tailwind" do
  describe "Base Functions" do
    it "tw" do
      show tw `shouldEqual` show (Tw :: Tw SkipAppendable)

    it "mt_4" do
      show mt_4 `shouldEqual` "mt-4"

    it "hover" do
      show (hover mt_4) `shouldEqual` "hover:mt-4"

    it "sm" do
      show (sm mt_4) `shouldEqual` "sm:mt-4"
