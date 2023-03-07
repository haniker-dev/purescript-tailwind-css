module Test.GenTest.Screen where

import Prelude

import Tailwind (mt_4, sm)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Generated Screen Functions" do
  it "sm" do
    show (sm mt_4) `shouldEqual` "sm:mt-4"
