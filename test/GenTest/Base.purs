module Test.GenTest.Base where

import Prelude

import Tailwind (Tw(..), _mt_4, mt_4, px_0_dot_5, tw, w_4_over_5)
import Tailwind.Class.Appendable (SkipAppendable)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Helper (print)

spec :: Spec Unit
spec = describe "Generated Base Functions" do
  it "tw" do
    print tw `shouldEqual` print (Tw :: Tw SkipAppendable)

  it "mt_4" do
    print mt_4 `shouldEqual` "mt-4"

  it "-mt_4" do
    print _mt_4 `shouldEqual` "-mt-4"

  it "px-0.5" do
    print px_0_dot_5 `shouldEqual` "px-0.5"

  it "w_4_over_5" do
    print w_4_over_5 `shouldEqual` "w-4/5"
