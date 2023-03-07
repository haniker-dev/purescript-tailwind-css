module Test.GenTest.Base where

import Prelude

import Tailwind (Tw(..), _mt_4, mt_4, px_0_dot_5, tw, w_4_over_5)
import Tailwind.Class.Appendable (SkipAppendable)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Generated Base Functions" do
  it "tw" do
    show tw `shouldEqual` show (Tw :: Tw SkipAppendable)

  it "mt_4" do
    show mt_4 `shouldEqual` "mt-4"

  it "-mt_4" do
    show _mt_4 `shouldEqual` "-mt-4"

  it "px-0.5" do
    show px_0_dot_5 `shouldEqual` "px-0.5"

  it "w_4_over_5" do
    show w_4_over_5 `shouldEqual` "w-4/5"
