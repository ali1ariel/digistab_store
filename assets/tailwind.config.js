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
        'white-purple': '#FFEBFA',
        'white-red': '#FFEBEB',
        'opal': '#a5cabf',
        'coral': '#E88787'
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