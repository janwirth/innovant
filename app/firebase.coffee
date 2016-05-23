module.exports = ->
  url = 'project-2654865812003744343.firebaseio.com'

  firebase =
    innovation: (slug) =>
      ref = new Firebase url
      ref.child('innovations').orderByChild('name').equalTo(slug)

    innovations: =>
      ref = new Firebase url
      ref.child 'innovations'

  firebase
