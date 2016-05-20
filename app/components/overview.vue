<template lang="jade">
.Overview
  .Overview-heading Overview
  .InnovationCard-wrap
    .InnovationCard--create(v-on:click='createInnovation')
      .InnovationCard-title New Innovation
    .InnovationCard--clear(v-on:click='clearInnovations')
      .InnovationCard-title Clear Innovations
    .InnovationCard(v-for='innovation in innovations' v-link='{ path: "/edit/" + innovation.currentVersion._id + "/" + innovation.currentVersion.slug}')
      .InnovationCard-title {{{innovation.currentVersion.name}}}
</template>

<script lang="coffee">
demoInnovation = require '../resources/demoInnovation'

slug = require 'slug'

DB = require '../localStorageDB.js'


module.exports =

  data: ->
    @db = DB 'innovant', localStorage

    if !@db.tableExists 'innovations'
      @db.createTable 'innovations', ['versions']

    if !@db.tableExists 'innovationVersions'
      @db.createTable 'innovationVersions', ['_id', 'name', 'modules']

    @db.commit()

    @getInnovationsFromDB = =>
      innovations = @db.queryAll 'innovations'
      for innovation in innovations
        currentVersionId = innovation.versions[0]
        innovationVersions = @db.queryAll 'innovationVersions',
          query:
            _id: currentVersionId
        innovation.currentVersion = innovationVersions[0]
        innovation.currentVersion.slug = slug innovation.currentVersion.name
      innovations
    return {innovations: @getInnovationsFromDB()}

  methods:
    createInnovation: ->
      newInnovation = demoInnovation()
      @db.insert 'innovationVersions', newInnovation
      @db.insert 'innovations', 
        versions: [newInnovation._id]
      @db.commit()
      @innovations = @getInnovationsFromDB()

    clearInnovations: ->
      @db.deleteRows 'innovations'
      @db.deleteRows 'innovationVersions'
      @db.commit()
      @innovations = @getInnovationsFromDB()

</script>
