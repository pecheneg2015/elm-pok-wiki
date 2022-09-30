const  theme  = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './src/**/*.{html,js,elm}',
  ],
  darkMode: 'media', // or 'media' or 'class'
  theme: {
    ...theme,
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
};