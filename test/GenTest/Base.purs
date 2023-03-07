module Test.GenTest.Base where

import Prelude

import Tailwind (Tw(..), mt_4, tw)
import Tailwind.Class.Appendable (SkipAppendable)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Generated Base Functions" do
  it "tw" do
    show tw `shouldEqual` show (Tw :: Tw SkipAppendable)

  it "mt_4" do
    show mt_4 `shouldEqual` "mt-4"

