const defaultTheme = require('tailwindcss/defaultTheme')
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/components/**/*'
  ],
  theme: {
    extend: {
      fontFamily: {
        bukhari: ['BukhariScript', 'sans-serif'],
        roboto: ['Roboto', 'sans-serif'],
        sans: ['Lexend', ...defaultTheme.fontFamily.sans]
      },

      fontSize: {
        '2xs': ['0.625rem', '0.75rem'], // [10px, 12px]
        'xs': ['0.75rem', '1.125rem'], // [12px, 18px]
        'sm': ['1rem', '1.125rem'], // [16px, 18px]
        'md': ['1rem', '1.5rem'], // [16px, 24px]
        'lg': ['1.25rem', '2rem'], // [20px, 32px]
        '1.5xl': ['1.375rem', '1.875rem'], // [22px, 30px]
        '3xl': ['1.75rem', '2.25rem'], // [28px, 36px]
        '4xl': ['2rem', '2.5rem'], // [32px, 40px]
        '5xl': ['2.5rem', '3rem'], // [40px, 48px]
        '6xl': ['3.25rem', '4.25rem'], // [52px, 68px]
        '7xl': ['4rem', '4.5rem'], // [64px, 72px]
      },

      colors: {
        gray:{
          50: '#EAE5E1',
          150: '#E6E0DB',
          200: '#BAC9BD',
          300: '#CABFB5',
          400: '#7E766E',
          500: '#5B5F62'
        },
        blue: {
          200: '#F5F7FF'
        },
        green: {
          100: '#D9E8DC',
          200: '#4DB260',
          600: '#13391F',
          700: '#337740',
          900: '#13391F'
        },
        neutral: {
          50: '#FFFDF5',
          100: '#FAF9F8',
          200: '#F2F0ED',
          300: '#EAE5E1',
          500: '#DFD9D2',
          700: '#A09992',
          800: '#7D756D'
        },
        yellow: {
          100: '#FFFDF7',
          150: '#FEFCF6',
          200: '#FFF1AD',
          400: '#FFF8E0',
          500: '#FFE899',
          550: '#FFD237',
          600: '#FFC600'
        }
      },
      spacing: {
        '100': '6.25rem', // 100px
        '140': '35rem', // 560px
        '3.5p': '3.5%',
        '12p': '12%',
        '30p': '30%'
      },
      inset: {
        '266': '16.625rem',
      },
      width: {
        '1/2-screen': '43.5vw',
        '13': '3.25rem', // 52px
        '25': '6.25rem', // 100px
        '38': '9.6875rem', // 155px
        '42': '10.625rem', // 170px
        '43': '11.0625rem', // 177px
        '76': '19rem', // 304px
        '82': '20.5rem', // 328px
        '88': '22rem', // 352px
        '90': '22.5rem', // 360px
        '95': '23.75 rem', // 380px
        '107': '26.75rem', // 428px
        '197': '49.25rem',// 788px
        '30r': '30rem'
      },
      height: {
        '13': '3.25rem', // 52px
        '15': '3.75rem', // 60px
        '18': '4.5rem', // 72px
        '50': '12.5rem', // 200px
        '57': '14.25rem', // 228px
        '88': '22rem', // 352px
        '95': '23.75 rem', // 380px
        '114': '28.5rem', // 456px
        '197': '49.25rem',// 788px
        '206': '51.5rem', // 824px
        '52p': '52%',
        '54p': '54%',
        '88p': '88%'
      },
      margin: {
        '13': '3.25rem', // 52px
        '15': '3.75rem', // 60px
        '22': '5.5rem', // 88px
        '90': '22.5rem', // 360px
        '29r': '29rem',
      },
      dropShadow: {
        'yellow': '0 0 0.25rem rgba(255, 198, 0, 1)',
        'neutral': '0 0 0.25rem rgba(230, 224, 219, 0.80)'
      },
      scale: {
        '58': '0.58',
        '45': '0.45',
        '56': '0.56',
        '42': '0.42'
      }
    },
  }
}

