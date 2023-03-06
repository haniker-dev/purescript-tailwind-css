module Example where

import Effect (Effect)
import Effect.Console (log)
import Prelude (Unit, show, ($))
import Tailwind (Tw, bg_red_100, bg_red_500, hover, mb_2, mt_4, my_4, sm, tw, (~))

-- Create a record to hold all your styles
style
  :: { container :: Tw "my-4 mb-2 sm:mt-4 sm:bg-red-100 hover:mt-4 hover:bg-red-500"
     -- Compiler can infer the correct combined CSS classes at compile time ie. Tw "my-4 mb-2 sm:mt-4 sm:bg-red" 
     }
style =
  { container: tw -- Optional empty classname for nicer code formatting

      ~ my_4
      ~ mb_2
      ~ sm -- Easily add breakpoint
          ( tw
              ~ mt_4
              ~ bg_red_100
          )
      ~ hover -- Easily add pseduo-classes
          ( tw
              ~ mt_4
              ~ bg_red_500
          )
  }

example :: Effect Unit
example = do
  -- In the compiled-JS, it will only have a single string of "my-4 mb-2 sm:mt-4 sm:bg-red" which is easy for tailwindcss to scan for
  log $ show $ style.container

