css_pipeline = require 'css-pipeline'
js_pipeline = require 'js-pipeline'
autoprefixer = require 'autoprefixer-stylus'
axis         = require 'axis'
rupture      = require 'rupture'

browserify   = require 'roots-browserify'
vueify       = require 'vueify'
coffeeify    = require 'coffeeify'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    js_pipeline(files: 'assets/libs/*.js')
    browserify
      files: 'app/app.coffee'
      out: 'app.js'
      transforms: [coffeeify, vueify]
    css_pipeline(files: 'assets/css/*.styl')
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true
