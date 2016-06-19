# dummy innovation page data
#

modules = require './modules'
inputs = require './inputs'
fonts = require './fonts'

module.exports =
  templates:

    complete: ->
      name: 'Bahnbrechende Innovation'
      description: 'Eine kurze Beschreibung'
      published: false
      font: fonts[4]
      colors:
        text: '#10CA7E'
        background: '#000000'
      modules: [
        modules.Hero[1]
        ,
        modules.Preis[0]
      ]

    empty: ->
      name: 'Neue Innovation'
      description: 'Eine kurze Beschreibung'
      published: false
      font: fonts[0]
      colors:
        text: '#000000'
        background: '#FFFFFF'
      modules: []

    triton: ->
      name: 'Triton Schnorchel'
      description: 'Tauchen ohne O2'
      published: false
      font: fonts[4]
      colors:
        text: '#ADD8E6'
        background: '#000000'
      modules: [
        modules.Hero[1]
        ,
        modules.Preis[1]
      ]

  modules: modules

  inputs: inputs
