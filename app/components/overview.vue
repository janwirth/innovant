<template lang="jade">
.Overview
  .Overview-heading Overview
  .InnovationCard-wrap
    .InnovationCard--create(v-on:click='createInnovation')
      .InnovationCard-title New Innovation
    .InnovationCard--clear(v-on:click='clearInnovations')
      .InnovationCard-title Clear Innovations
    .InnovationCard(v-for='innovation in innovations' v-link='{ path: "/edit/" + innovation.slug}')
      .InnovationCard-title {{{innovation.name}}}
</template>

<script lang="coffee">
innovationTemplate = require '../resources/innovationTemplate'

db = require('../firebase.coffee')()



module.exports =

  firebase:
    innovations: db.innovations()

  methods:
    createInnovation: () ->
      @$firebaseRefs.innovations.push innovationTemplate() # new

    clearInnovations: ->
      @$firebaseRefs.innovations.remove()

</script>
