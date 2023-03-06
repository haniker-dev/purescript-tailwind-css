/** @type {import('tailwindcss').Config} */
export default {
  content: [],
  darkMode: "media", // or 'class'
  theme: {
    screens: {
      sm: "640px",
      md: "768px",
      lg: "1024px",
      xl: "1280px",
      // "2xl": "1536px",
      // Do not have a screen breakpoint starting with a number
      // as Purescript does not support function starting with a number
      // instead use something like "xxl": "1536px",
    },
  },
  plugins: [],
};
