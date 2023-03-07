module Example where

import Tailwind

import Effect (Effect)
import Effect.Console (log)
import Prelude (Unit, show, ($))
import Tailwind.Class.MapPrefix (class MapPrefix)

-- Create a record to hold all your styles
style
  :: {
       -- Compiler can infer the correct combined CSS classes at compile time
       container :: _
     }
style =
  { container: tw -- Optional empty classname for nicer code formatting

      ~ my_4
      ~ _mt_4 -- "-mt-4" negative mt-4
      ~ px_0_dot_5 -- "px-0.5"
      ~ w_4_over_5 -- "w-4/5"
      ~ sm -- Easily add breakpoint
          ( tw
              ~ mt_4
              ~ bg_red_100
          )
      ~ hover -- Easily add pseduo-classes
          ( tw
              ~ mt_4
              ~ bg_red_500
              ~ arbitraryPadding -- Define and use your own arbitrary class
          )
      ~ arbitraryVariants -- Define and use your own arbitrary variant
          ( tw
              ~ mt_8
          )
  }

arbitraryPadding :: Tw "p-[5px]"
arbitraryPadding = Tw

arbitraryVariants :: ∀ a b. MapPrefix "[&:nth-child(3)]:" a b => Tw a -> Tw b
arbitraryVariants _ = Tw

example :: Effect Unit
example = do
  -- In the compiled-JS, it will only have a single string of "my-4 mb-2 sm:mt-4 sm:bg-red" which is easy for tailwindcss to scan for
  log $ show $ style.container

