module Test.Tailwind.Class.Appendable where

import Prelude

import Tailwind (Tw(..), (~))
import Tailwind.Class.Appendable (SkipAppendable)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Helper (print)

spec :: Spec Unit
spec = describe "class Appendable" do
  it "Merges two themes" do
    let c = (a ~ b :: Tw "c-a c-b")
    print c `shouldEqual` "c-a c-b"

  it "Ignores `Skip` Symbol in merging" do
    let c = (css ~ a ~ css ~ b ~ css :: Tw "c-a c-b")
    print c `shouldEqual` "c-a c-b"

css :: Tw SkipAppendable
css = Tw

a :: Tw "c-a"
a = Tw

b :: Tw "c-b"
b = Tw
