module Test.GenTest.Target where

import Prelude

import Data.Newtype (unwrap)
import Halogen.VDom.DOM.Prop (Prop(..))
import TailwindHalogen as TwHalogen
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Unsafe.Coerce (unsafeCoerce)

spec :: Spec Unit
spec = describe "Generated Target Functions" do
  it "Halogen css" do
    halogenRedAttr `shouldEqual` "className: halogen-red"

halogenRedAttr :: String
halogenRedAttr =
  case (unwrap $ TwHalogen.css TwHalogen.halogen_red) of
    Property name value -> name <> ": " <> unsafeCoerce value
    _ -> ""

