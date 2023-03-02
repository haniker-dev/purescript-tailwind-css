module Test.Tailwind.Tw where

import Prelude

import Tailwind.Tw (SkipAppendable, Tw(..), mapPrefix, (~))
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Type.Prelude (Proxy(..))

spec :: Spec Unit
spec = describe "Tw" do
  describe "class Appendable" do
    it "Merges two themes" do
      let c = (a ~ b :: Tw "c-a c-b")
      show c `shouldEqual` "c-a c-b"

    it "Ignores `Skip` Symbol in merging" do
      let c = (css ~ a ~ css ~ b ~ css :: Tw "c-a c-b")
      show c `shouldEqual` "c-a c-b"

  describe "class MapPrefix" do
    it "maps a prefix" do
      let c = (a ~ b :: Tw "c-a c-b")
      let d = (mapPrefix (Proxy :: Proxy "p:") c :: Tw "p:c-a p:c-b")
      show d `shouldEqual` "p:c-a p:c-b"

    it "chains multiple mapping of prefix" do
      let c = (a ~ b :: Tw "c-a c-b")
      let d = (mapPrefix (Proxy :: Proxy "p:") c :: Tw "p:c-a p:c-b")
      let e = (mapPrefix (Proxy :: Proxy "h:") d :: Tw "h:p:c-a h:p:c-b")
      show e `shouldEqual` "h:p:c-a h:p:c-b"

    it "maps a prefix over an empty Tw" do
      let c = (Tw :: Tw "")
      let d = (mapPrefix (Proxy :: Proxy "p:") c :: Tw "")
      show d `shouldEqual` ""

    it "maps an empty prefix" do
      let c = (a ~ b :: Tw "c-a c-b")
      let d = (mapPrefix (Proxy :: Proxy "") c :: Tw "c-a c-b")
      show d `shouldEqual` "c-a c-b"

css :: Tw SkipAppendable
css = Tw

a :: Tw "c-a"
a = Tw

b :: Tw "c-b"
b = Tw

