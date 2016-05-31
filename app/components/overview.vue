<template lang="jade">
.Overview
  .Overview-heading Overview
  .InnovationCard-wrap
    .InnovationCard--create(v-on:click='createInnovation')
      .InnovationCard-title New Innovation
    .InnovationCard--clear(v-on:click='clearInnovations')
      .InnovationCard-title Clear Innovations
    .InnovationCard(v-for='innovation in innovations' v-link='{ path: "/edit/" + innovation.currentVersion.ID + "/" + innovation.currentVersion.slug}')
      .InnovationCard-title {{{innovation.currentVersion.name}}}
</template>

<script lang="coffee">
demoInnovation = require '../resources/demoInnovation'
utils = require '../utilities'
slug = utils.slug

DB = window.localStorageDB


module.exports =


  data: ->

    # initialize Database

    @db = DB 'innovant', localStorage

    if !@db.tableExists 'innovations'
      @db.createTable 'innovations', ['versions']

    if !@db.tableExists 'innovationVersions'
      @db.createTable 'innovationVersions', ['name', 'colors', 'modules']

    if !@db.tableExists 'results'
      @db.createTable 'results', ['innovationVersionID', 'sessionID', 'results']

    @db.commit()

    # define method for reading database

    @getInnovationsFromDB = =>
      innovations = @db.queryAll 'innovations'
      for innovation in innovations
        currentVersionId = innovation.versions[0]
        # read latest version of innovation
        innovationVersions = @db.queryAll 'innovationVersions',
          query:
            ID: currentVersionId
        innovation.currentVersion = innovationVersions[0]
        innovation.currentVersion.slug = slug innovation.currentVersion.name
      innovations
    return {innovations: @getInnovationsFromDB()}

  methods:

    # read innovation template and insert it into database
    createInnovation: ->
      newInnovation = demoInnovation.complete()
      versionId = @db.insert 'innovationVersions', newInnovation
      @db.insert 'innovations',
        versions: [versionId]
      @db.commit()
      @innovations = @getInnovationsFromDB()

    # remove all innovations from the db
    clearInnovations: ->
      @db.deleteRows 'innovations'
      @db.deleteRows 'innovationVersions'
      @db.commit()
      @innovations = @getInnovationsFromDB()

</script>
