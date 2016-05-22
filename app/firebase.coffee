ref = new Firebase 'project-2654865812003744343.firebaseio.com'

firebase =
  innovation: (slug) ->
    console.log 'querying'
    ref.child('innovations').equalTo(slug)

  innovations: ->
    console.log 'querying'
    ref.child 'innovations'

module.exports = firebase
