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
        Heading: 'Hier klicken zum Text einfügen',
        Text: 'Ein Untertitel'
        Image: 'http://store.storeimages.cdn-apple.com/4973/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone6/select/iphone6-select-2014_GEO_US?wid=1200&hei=630&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=cAxkZ1'

      analytics:
        active: true
        question:
          text: 'Hier klicken, um die Frage zu bearbeiten?'
          explanation: 'Hier ist Platz für eine weitergehende erklärung.'
        inputs: [
          inputs.range()
          ,
          inputs.textarea()
          ]
    }
    {
      type: 'hero'

      content:
        Heading: '<b>Triton</b> - Die weltweit ersten künstlichen Kiemen',
        Text: 'Tauchen Sie jetzt mit Triton ab und erforschen Sie die Meere ohne die lästigen Tauchflaschen. Triton ermöglicht Ihnen 45 min Taucherlebnis ohne jegliches Tauchequipment.'
        Image: 'img/triton/detail.jpg'

      analytics:
        active: true
        question:
          text: 'Wie wirkt Triton auf den ersten Blick auf Sie?'
          explanation: ''
        inputs: [
            inputs.range('positiv', 'negativ')
          ,
            inputs.range('interessant', 'uninteressant')
          ,
            inputs.range('nützlich', 'nutzlos')
          ,
            inputs.range('ansprechend', 'langweilig')
          ]
    }
  ]

  'Einleitung / Demo': [ 'a', 'b']
  'USP / Features': [ 'a', 'b']

  'Preis': [
    {
      type: 'table'

      content:
        Heading: 'Hier klicken, um die Überschrift zu ändern!',
        Table: tableHtml

      analytics:
        active: false
        question:
          text: 'Eine Frage zum Preis?'
          explanation: 'Weitere Hinweise.'
        inputs: [
          inputs.range('günstig', 'zu teuer')
          ]
      }

    {
      type: 'priceCards'

      content:
        Heading: 'Nicer Preis',
        Prices: [
          {
            title: 'Vorbestellung'
            cost: '$ 299'
          }
          {
            title: 'UVP'
            cost: '$ 399'
          }

        ]

      analytics:
        active: true
        question:
          text: 'Ist der Preis für Triton in Ihren Augen angemessen?'
          explanation: ''
        inputs: [
          inputs.range('günstig', 'zu teuer')
          ]
    }
  ]

  'Selling Points': [ 'a', 'b']
  'Trust': [
    {
      type: 'badges'

      content:
        Heading: 'Hier ist Platz für einen Satz, der Vertrauen schafft.',
        Badges: [
          {src: 'http://www.holzspielzeugkauf.de/images/siegel-kennzeichen/GS-Zeichen-Gepruefte-Sicherheit.png'}
          {src: 'https://upload.wikimedia.org/wikipedia/de/thumb/6/63/T%C3%9CV_S%C3%BCd_logo.svg/768px-T%C3%9CV_S%C3%BCd_logo.svg.png'}
        ]

      analytics:
        active: false
        question:
          text: 'Stellen Sie eine Frage zur Relevanz der Siegel?'
          explanation: 'Hier ist Platz für eine weitere Erklärung.'
        inputs: [
          inputs.textarea()
          ]
    }
    {
      type: 'badges'

      content:
        Heading: 'So sicher wie Luft zum atmen.',
        Badges: [
          {src: 'http://www.holzspielzeugkauf.de/images/siegel-kennzeichen/GS-Zeichen-Gepruefte-Sicherheit.png'}
          {src: 'https://upload.wikimedia.org/wikipedia/de/thumb/6/63/T%C3%9CV_S%C3%BCd_logo.svg/768px-T%C3%9CV_S%C3%BCd_logo.svg.png'}
        ]

      analytics:
        active: false
        question:
          text: 'Kennen Sie weitere Institute, die Triton überprüfen sollten?'
          explanation: 'Hier ist Platz für eine weitere Erklärung.'
        inputs: [
          inputs.textarea()
          ]
    }

  ]
  'Feedback': [ 'a', 'b']

