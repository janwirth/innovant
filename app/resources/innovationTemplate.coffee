# dummy innovation page data
#
tableHtml =
"""
<table contenteditable="true"><thead><tr><td>Feature</td><th>Basic</th><th>Premium</th><th>Pro</th></tr></thead><tbody><tr><td>Unlimited Streaming</td><td>X</td><td>X</td><td>X</td></tr><tr><td>Downloads</td><td></td><td>X</td><td>X</td></tr><tr><td>High Quality Streaming</td><td></td><td>X</td><td>X</td></tr><tr><td>Remixes</td><td></td><td></td><td>X</td></tr></tbody></table>
"""

# FUNCTIONAL UTILITIES

random = (max,min=0) -> Math.floor(Math.random() * (max - min) + min)

slug = (str) ->
  str = str.replace(/^\s+|\s+$/g, "").toLowerCase() # trim and force lowercase
  from = "àáäâèéëêìíïîòóöôùúüûñç·/_,:;"
  to   = "aaaaeeeeiiiioooouuuunc------"
  for i in [i..from.length]
    str = str.replace(new RegExp(from.charAt(i), "g"), to.charAt(i))
  # remove accents, swap ñ for n, etc  
  str = str.replace(/[^a-z0-9 -]/g, "").replace(/\s+/g, "-").replace(/-+/g, "-")
  # remove invalid chars, collapse whitespace and replace by -, collapse dashes
  return str # unnecessary line, but for clarity

# STATEFUL TEMPLATE

module.exports = ->
  name = "Take over the world in #{random 100} days"
  template =
    name: name
    slug: slug name
    modules: [
        type: 'hero'
        content:
          Heading: 'Make a dent in the universe',
          Text: 'Our revolutionary concept is just great'
          Image: 'https://images.unsplash.com/photo-1459664018906-085c36f472af?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=0790a8686cb07ac8851066ef544f1082'
        analytics:
          active: true
          question:
            text: 'How attractive do you find this design?'
            explanation: 'Please do not consider the color scheme.'
          inputs: [
              type: 'range'
              label: 'ugly'
              labelHigh: 'attractive'
            ,
              type: 'textarea'
            ]
      ,
        type: 'table'
        content:
          Heading: 'Compare our features',
          Table: tableHtml
        analytics:
          active: false
    ]
  template
