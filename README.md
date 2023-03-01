# Purescript Tailwind
Type-safe Tailwind CSS with zero runtime performance!

This package provides typed functions as Tailwind CSS classes/modifers
and generate the final combined CSS classnames _at compile time_ 
for `tailwindcss` to detect and generate the CSS code.

## How It Works
*TODO* Add a reference to src/Example.purs

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

--config,-c    Path to tailwind.config.js
--help,-h      Show this help message.
--output,-o    Directory for the generated CSS function
```

Based on your `tailwind.config.js`, this will generate all the following files:
- `generated-src/Tailwind.purs` (Re-exports all functions in `Tailwind/*.purs`)
- `generated-src/Tailwind/Base.purs`
- `generated-src/Tailwind/Screen.purs`
- `generated-src/Tailwind/Modifer.purs`

Happy coding!

## TODOs

- [ ] Provide CLI 
- [ ] Hard-coded theme.extend.screens https://tailwindcss.com/docs/screens
- [ ] Hard-coded pseudo-classes https://tailwindcss.com/docs/hover-focus-and-other-states#quick-reference
- [ ] *ASSUME* all other parts of Tailwind Config are generated eg. extra colors, spacing, etc
