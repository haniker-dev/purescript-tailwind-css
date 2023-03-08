module Test.GenTest.CustomCss where

import Prelude

import Tailwind (custom_css_alone, custom_css_parent, custom_css_child, custom_css_child_dot, custom_css_child_greater)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Generated Custom Css Functions" do
  it ".custom-css-alone" do
    show custom_css_alone `shouldEqual` "custom-css-alone"

  it ".custom-css-parent .custom-css-child" do
    show custom_css_parent `shouldEqual` "custom-css-parent"
    show custom_css_child `shouldEqual` "custom-css-child"

  it "div.custom-css-child-dot" do
    show custom_css_child_dot `shouldEqual` "custom-css-child-dot"

  it "div > .custom-css-child-greater" do
    show custom_css_child_greater `shouldEqual` "custom-css-child-greater"
