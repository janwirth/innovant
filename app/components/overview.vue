<template lang="jade">
.Overview
  .Overview-heading Overview
  .InnovationCard-wrap
    .InnovationCard--create(v-on:click='createInnovation')
      .InnovationCard-title New Innovation
    .InnovationCard--clear(v-on:click='clearInnovations')
      .InnovationCard-title Clear Innovations
    .InnovationCard(v-for='innovation in innovations' v-link='{ path: "/edit/" + innovation.currentVersion.slug}')
      .InnovationCard-title {{{innovation.currentVersion.name}}}
</template>

<script lang="coffee">
demoInnovation = require '../resources/demoInnovation'

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

random = (max,min=0) -> Math.floor(Math.random() * (max - min) + min)

prepare = (innovation) ->
  innovation.currentVersion.name += " #{random 100}"
  innovation.slug = innovation.currentVersion.slug = slug defaultInnovationVersion.name
  innovation


DB = window.localStorageDB


ref = new Firebase 'project-2654865812003744343.firebaseio.com'

module.exports =

  firebase:
    innovations: ref.child 'innovations'
    innovationVersions: ref.child 'innovationVersions'
    results: ref.child 'results'

  methods:
    createInnovation: ->
      @$firebaseRefs.innovations.push
        prepare
          currentVersion: demoInnovation()

    clearInnovations: ->
      @$firebaseRefs.innovations.remove()

</script>
