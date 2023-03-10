module Test.GenTest.CustomCss where

import Prelude

import Tailwind as Tw
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec = describe "Generated Custom Css Functions" do
  it ".custom-css-alone" do
    show Tw.custom_css_alone `shouldEqual` "custom-css-alone"

  it ".custom-css-parent .custom-css-child" do
    show Tw.custom_css_parent `shouldEqual` "custom-css-parent"
    show Tw.custom_css_child `shouldEqual` "custom-css-child"

  it "div.custom-css-child-dot" do
    show Tw.custom_css_child_dot `shouldEqual` "custom-css-child-dot"

  it "div > .custom-css-child-greater" do
    show Tw.custom_css_child_greater `shouldEqual` "custom-css-child-greater"

  it ".custom-css-attribute-for[for=\"email\"]" do
    show Tw.custom_css_attribute_for `shouldEqual` "custom-css-attribute-for"

  it ".custom-css-attribute-value[value^=\"Go\"]" do
    show Tw.custom_css_attribute_value `shouldEqual` "custom-css-attribute-value"

  it ".custom-css-attribute-src[src$=\".png\"]" do
    show Tw.custom_css_attribute_src `shouldEqual` "custom-css-attribute-src"

  it ".custom-css-attribute-title[title~=create]" do
    show Tw.custom_css_attribute_title `shouldEqual` "custom-css-attribute-title"

  it ".custom-css-attribute-lang[lang|=nl]" do
    show Tw.custom_css_attribute_lang `shouldEqual` "custom-css-attribute-lang"

  it ".custom-css-pseudo-active:active" do
    show Tw.custom_css_pseudo_active `shouldEqual` "custom-css-pseudo-active"

  it ".custom-css-pseudo-after::after" do
    show Tw.custom_css_pseudo_after `shouldEqual` "custom-css-pseudo-after"

  it ".custom-css-pseudo-range:in-range" do
    show Tw.custom_css_pseudo_range `shouldEqual` "custom-css-pseudo-range"

  it ".custom-css-pseudo-nth:nth-child(2)" do
    show Tw.custom_css_pseudo_nth `shouldEqual` "custom-css-pseudo-nth"

  it ".custom-css-pseudo-lang:lang(fr)" do
    show Tw.custom_css_pseudo_lang `shouldEqual` "custom-css-pseudo-lang"
