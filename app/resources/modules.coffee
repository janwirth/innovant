inputs = require './inputs'

tableHtml =
  """
<table contenteditable="true"><thead><tr><td>Feature</td><th>Basic</th><th>Premium</th><th>Pro</th></tr></thead><tbody><tr><td>Unlimited Streaming</td><td>X</td><td>X</td><td>X</td></tr><tr><td>Downloads</td><td></td><td>X</td><td>X</td></tr><tr><td>High Quality Streaming</td><td></td><td>X</td><td>X</td></tr><tr><td>Remixes</td><td></td><td></td><td>X</td></tr></tbody></table>
"""

module.exports =
  'Hero': [
    {
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
    }
    {
      type: 'hero'

      content:
        Heading: 'Triton - Die weltweit ersten künstlichen Kiemen',
        Text: 'Tauchen Sie jetzt mit Triton ab und erforschen Sie die Meere ohne die lästigen Tauchflaschen. Triton ermöglicht Ihnen 45 min Taucherlebnis ohne jegliches Tauchequipment.'
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
    }
  ]

  'Einleitung / Demo': [ 'a', 'b']
  'USP / Features': [ 'a', 'b', 'c', 'd']

  'Preis': [
    {
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
      }
  ]

  'Selling Points': [ 'a', 'b']
  'Trust': [ 'a', 'b']
  'Feedback': [ 'a', 'b']

