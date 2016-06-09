# dummy innovation page data
#

modules = require './modules'
inputs = require './inputs'
fonts = require './fonts'

module.exports =

  complete: ->
    name: 'Bahnbrechende Innovation'
    description: 'Eine kurze Beschreibung'
    published: false
    font: fonts[2]
    colors:
      text: '#10CA7E'
      background: '#000'
    modules: [
      modules.Hero[1]
      ,
      modules.Preis[0]
    ]

  triton: ->
    name: 'Triton Schnorchel'
    description: 'Tauchen ohne O2'
    published: false
    font: fonts[0]
    colors:
      text: '#10CA7E'
      background: '#000'
    modules: [
      modules.Hero[1]
      ,
      modules.Preis[0]
    ]

  modules: modules

  inputs: inputs
