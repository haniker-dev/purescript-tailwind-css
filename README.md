# Purescript Tailwind
Type-safe Tailwind CSS with zero runtime performance!

This package provides typed functions as Tailwind CSS classes/modifers
and generate the final combined CSS classnames _at compile time_ 
for `tailwindcss` to detect and generate the CSS code.

## Example
```
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
       -- Tw "my-4 -mt-4 px-0.5 w-4/5 sm:mt-4 sm:bg-red-100 hover:mt-4 hover:bg-red-500 hover:p-[5px] [&:nth-child(3)]:mt-8 2xl:mt-10"
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
      ~ _2xl -- names starting with number is prefixed with an underscore
          ( tw
              ~ mt_10
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

```

Whenever your Purescript code is compiled, 
`tailwindcss` will scan the compiled-JS files in the `output` folder 
and automatically generate a CSS file based on the classes that are in the files. 
See [class-detection-in-depth](https://tailwindcss.com/docs/content-configuration#class-detection-in-depth) for more information.

## Installation Guide
```
spago install tailwind-css
npm install --save-dev tailwindcss purescript-tailwind-css
```
You can choose any way to integrate Tailwind 
into your development pipeline as per [Tailwind Installation](https://tailwindcss.com/docs/installation).

Add Purescript compiled-JS folder (usually `./output/**/*.js`) in `tailwind.config.js`'s `content`

```javascript
// tailwind.config.js
module.exports = { 
  content: ["./output/**/*.js"],
  // … rest of your tailwind.config.js
}

```

Generate your Tailwind CSS Functions

Run

```bash
purs-tailwind-css --output ./generated-src [--config ./tailwind.config.js]

--config,-c         Path to tailwind.config.js
--help,-h           Show this help message.
--module-name,-n    Module name for the generated CSS function
--output,-o         Directory for the generated CSS function
```

Based on your `tailwind.config.js`, this will generate all the following files:
- `generated-src/Tailwind.purs` (Re-exports all functions in `Tailwind/*.purs`)
- `generated-src/Tailwind/Base.purs`
- `generated-src/Tailwind/Screen.purs`
- `generated-src/Tailwind/Modifer.purs`

Happy coding!

## Development
- Use `make run-cli-local` to generate a copy of Tailwind locally at `./gen-local` folder which is git-ignored
  Be sure to edit your `spago.dhall`'s `sources` to exclude `./gen-test` folder else you will have compiler error
  Eg. `sources = [ "src/**/*.purs", "cli/**/*.purs", "test/**/*.purs", "gen-local/**/*.purs" ]`
- Use `make run-cli-test` to generate a copy of Tailwind locally at `./gen-test` folder which is used by test cases
- See `Makefile` for all available commands to be used for development

## TODOs
- [ ] (Feature) Allow `input` css with custom CSS classes + test cases
- [ ] Add integration to Halogen
- [ ] Add CI to generate `gen-test` and it should not have any diff
