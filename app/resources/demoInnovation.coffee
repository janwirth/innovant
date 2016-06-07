# dummy innovation page data
#
tableHtml =
"""
<table contenteditable="true"><thead><tr><td>Feature</td><th>Basic</th><th>Premium</th><th>Pro</th></tr></thead><tbody><tr><td>Unlimited Streaming</td><td>X</td><td>X</td><td>X</td></tr><tr><td>Downloads</td><td></td><td>X</td><td>X</td></tr><tr><td>High Quality Streaming</td><td></td><td>X</td><td>X</td></tr><tr><td>Remixes</td><td></td><td></td><td>X</td></tr></tbody></table>
"""

inputs =
  range: ->
    type: 'range'
    label: 'unattraktiv'
    labelHigh: 'attraktiv'
  textarea: ->
    type: 'textarea'

modules =

  hero: ->
    type: 'hero'

    content:
      Heading: 'Das wird die Welt verändern',
      Text: 'Überzeugen Sie sich von unserem neuen Produkt'
      Image: 'https://images.unsplash.com/photo-1458400411386-5ae465c4e57e?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=47756f965e991bf72aa756b410929b04'

    analytics:
      active: true
      question:
        text: 'Wie gefällt Ihnen das Design?'
        explanation: 'Bitte gehe Sie dabei auch auf die Farbgebung ein.'
      inputs: [
        inputs.range()
        ,
        inputs.textarea()
        ]

  table: ->
    type: 'table'
    content:
      Heading: 'Vergleichen Sie unsere Produktmerkale!',
      Table: tableHtml
    analytics:
      active: false
      question:
        text: 'Wie gefällt Ihnen die Preisgestaltung?'
        explanation: 'Weitere Hinweise.'
      inputs: [
        inputs.range()
        ,
        inputs.textarea()
        ]

module.exports =

  complete: ->
    name: 'Bahnbrechende Innovation'
    description: 'Eine kurze Beschreibung'
    colors:
      text: '#10CA7E'
      background: '#000'
    modules: [
      modules.hero()
      ,
      modules.table()
    ]

  triton: ->
    name: 'Triton Schnorchel'
    description: 'Eine kurze Beschreibung'
    colors:
      text: '#10CA7E'
      background: '#000'
    modules: [
      modules.hero()
      ,
      modules.table()
    ]

  modules: modules

  inputs: inputs
