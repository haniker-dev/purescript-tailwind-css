module Example where

import Prelude (Unit, show, ($))

import Effect (Effect)
import Effect.Console (log)
import Tailwind (funs, hover, sm, (~))

-- Create a record to hold all your styles
style
  :: { container :: _ -- Compiler can infer the correct combined CSS classes at compile time ie. Tw "my-4 mb-2 sm:mt-4 sm:bg-red" 
     }
style =
  { container: funs.tw -- Optional empty classname for nicer code formatting

      ~ funs.my_4
      ~ funs.mb_2
      ~ sm -- Easily add breakpoint
          ( funs.tw
              ~ funs.mt_4
              ~ funs.bg_red_100
          )
      ~ hover -- Easily add pseduo-classes
          ( funs.tw
              ~ funs.mt_4
              ~ funs.bg_red_500
          )
  }

example :: Effect Unit
example = do
  -- In the compiled-JS, it will only have a single string of "my-4 mb-2 sm:mt-4 sm:bg-red" which is easy for tailwindcss to scan for
  log $ show $ style.container

