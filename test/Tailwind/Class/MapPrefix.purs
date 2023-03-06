module Test.Tailwind.Class.MapPrefix where

import Prelude

import Tailwind (Tw(..), (~))
import Tailwind.Class.MapPrefix (class MapPrefix)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "class MapPrefix" do
  it "maps a prefix" do
    let c = (a ~ b :: Tw "c-a c-b")
    let d = (mapPrefix (Tw :: Tw "p:") c :: Tw "p:c-a p:c-b")
    show d `shouldEqual` "p:c-a p:c-b"

  it "chains multiple mapping of prefix" do
    let c = (a ~ b :: Tw "c-a c-b")
    let d = (mapPrefix (Tw :: Tw "p:") c :: Tw "p:c-a p:c-b")
    let e = (mapPrefix (Tw :: Tw "h:") d :: Tw "h:p:c-a h:p:c-b")
    show e `shouldEqual` "h:p:c-a h:p:c-b"

  it "maps a prefix over an empty Tw" do
    let c = (Tw :: Tw "")
    let d = (mapPrefix (Tw :: Tw "p:") c :: Tw "")
    show d `shouldEqual` ""

  it "maps an empty prefix" do
    let c = (a ~ b :: Tw "c-a c-b")
    let d = (mapPrefix (Tw :: Tw "") c :: Tw "c-a c-b")
    show d `shouldEqual` "c-a c-b"

a :: Tw "c-a"
a = Tw

b :: Tw "c-b"
b = Tw

mapPrefix
  :: ∀ p a b
   . MapPrefix p a b
  => Tw p
  -> Tw a
  -> Tw b
mapPrefix _ _ = Tw
