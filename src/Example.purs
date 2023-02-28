module Example where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Tailwind (Theme, bg_red, hover, _css, mb_2, mt_4, my_4, sm, (~))

-- Create a record to hold all your styles
style
  :: { container :: _ -- Compiler can infer the correct combined CSS classes at compile time ie. Theme "my-4 mb-2 sm:mt-4 sm:bg-red" 
     }
style =
  { container: _css -- Optional empty classname for nicer code formatting

      ~ my_4
      ~ mb_2
      ~ sm -- Easily add breakpoint
          ( _css
              ~ mt_4
              ~ bg_red
          )
      ~ hover -- Easily add pseduo-classes
          ( _css
              ~ mt_4
              ~ bg_red
          )
  }

example :: Effect Unit
example = do
  -- In the compiled-JS, it will only have a single string of "my-4 mb-2 sm:mt-4 sm:bg-red" which is easy for tailwindcss to scan for
  log $ show $ style.container

