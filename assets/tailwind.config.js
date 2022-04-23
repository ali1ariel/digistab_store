module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {
      colors: {
        'white-blue': '#EBF4FF',
        'white-green': '#F5FBEE',
        'white-purple': '#F6ECFE',
        'white-red': '#FFEBEB',
        'opal': '#a5cabf',
        'coral': '#E88787',
        'purple-1': '#5d0a9d',
        'purple-light': '#B564F7',
        'purple-dark': '#380561'
      },
      maxWidth: {
        '1/4': '25%',
        '1/2': '50%',
        '3/4': '75%',
      },
      maxHeight: {
        '1/4': '25%',
        '1/2': '50%',
        '3/4': '75%'
      },
      height: {
        '192': '48rem'
      }
    }
  },
  variants: {},
  plugins: []
}