module Test.GenTest.Arbitrary where

import Prelude

import Tailwind (Tw(..))
import Tailwind.Class.MapPrefix (class MapPrefix)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Helper (print)

arbitraryPadding :: Tw "p-[5px]"
arbitraryPadding = Tw

arbitraryVariants :: ∀ a b. MapPrefix "[&:nth-child(3)]:" a b => Tw a -> Tw b
arbitraryVariants _ = Tw

spec :: Spec Unit
spec = describe "Arbitrary" do
  it "p-[5px]" do
    print arbitraryPadding `shouldEqual` "p-[5px]"

  it "[&:nth-child(3)]:" do
    (print $ arbitraryVariants arbitraryPadding) `shouldEqual` "[&:nth-child(3)]:p-[5px]"
