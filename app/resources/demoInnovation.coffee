# dummy innovation page data
#

modules = require './modules'
inputs = require './inputs'

module.exports =

  complete: ->
    name: 'Bahnbrechende Innovation'
    description: 'Eine kurze Beschreibung'
    published: false
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
