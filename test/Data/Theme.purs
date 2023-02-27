module Test.Data.Theme where

import Prelude

import Data.Theme (Skip, Theme(..), mapPrefix, (~))
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Type.Prelude (Proxy(..))

spec :: Spec Unit
spec = describe "Theme" do
  describe "class Appendable" do
    it "Merges two themes" do
      let c = (a ~ b :: Theme "c-a c-b")
      show c `shouldEqual` "c-a c-b"

    it "Ignores `Skip` Symbol in merging" do
      let c = (css ~ a ~ css ~ b ~ css :: Theme "c-a c-b")
      show c `shouldEqual` "c-a c-b"

  describe "class MapPrefix" do
    it "maps a prefix" do
      let c = (a ~ b :: Theme "c-a c-b")
      let d = (mapPrefix (Proxy :: Proxy "p:") c :: Theme "p:c-a p:c-b")
      show d `shouldEqual` "p:c-a p:c-b"

    it "chains multiple mapping of prefix" do
      let c = (a ~ b :: Theme "c-a c-b")
      let d = (mapPrefix (Proxy :: Proxy "p:") c :: Theme "p:c-a p:c-b")
      let e = (mapPrefix (Proxy :: Proxy "h:") d :: Theme "h:p:c-a h:p:c-b")
      show e `shouldEqual` "h:p:c-a h:p:c-b"

    it "maps a prefix over an empty Theme" do
      let c = (Theme :: Theme "")
      let d = (mapPrefix (Proxy :: Proxy "p:") c :: Theme "")
      show d `shouldEqual` ""

    it "maps an empty prefix" do
      let c = (a ~ b :: Theme "c-a c-b")
      let d = (mapPrefix (Proxy :: Proxy "") c :: Theme "c-a c-b")
      show d `shouldEqual` "c-a c-b"

css :: Theme Skip
css = Theme

a :: Theme "c-a"
a = Theme

b :: Theme "c-b"
b = Theme

