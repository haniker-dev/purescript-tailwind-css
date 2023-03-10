module Test.GenTest.Screen where

import Prelude

import Tailwind (mt_4, sm, _2xl)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Helper (print)

spec :: Spec Unit
spec = describe "Generated Screen Functions" do
  it "sm" do
    print (sm mt_4) `shouldEqual` "sm:mt-4"

  it "2xl" do
    print (_2xl mt_4) `shouldEqual` "2xl:mt-4"
