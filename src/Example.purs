module Example where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Tailwind (Theme, bg_red, _css, mb_2, mt_4, my_4, sm, (~))

example :: Effect Unit
example = do
  log $ show $ style

style
  :: { container :: Theme "my-4 mb-2 sm:mt-4 sm:bg-red"
     }
style =
  { container: _css
      ~ my_4
      ~ mb_2
      ~ sm
          ( _css
              ~ mt_4
              ~ bg_red
          )
  }

