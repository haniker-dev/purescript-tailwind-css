import defaultTheme from "tailwindcss/defaultTheme.js";

/** @type {import('tailwindcss').Config} */
export default {
  content: [],
  presets: [],
  darkMode: "media", // or 'class'
  theme: {
    screens: {
      ...defaultTheme.screens,
    },
    extend: {
      screens: {
        "test-screen-modifier": "2000px",
      },
    },
  },
  plugins: [],
};
