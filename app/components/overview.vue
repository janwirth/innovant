<template lang="jade">
.Overview
  .InnovationCard-wrap

    .InnovationCard.InnovationCard--create(v-on:click='createInnovation')
      .InnovationCard-icon(src='img/icons/add.svg')
      .InnovationCard-title Neue Innovation

    .InnovationCard.InnovationCard--clear(v-on:click='clearInnovations')
      .InnovationCard-icon(src='img/icons/delete.svg')
      .InnovationCard-title [DEV: clear all innovations]

    .InnovationCard(v-for='innovation in innovations' v-bind:style='{background: innovation.currentVersion.colors.background,\
        color: innovation.currentVersion.colors.text,\
        "border-color": innovation.currentVersion.colors.text}')

      .InnovationCard-icon.show(v-if='innovation.results.CSV == undefined')

      .InnovationCard-icon.download(v-if='innovation.results.CSV')
      .InnovationCard-downloadBar(v-if='innovation.results.CSV')
        a(v-bind:download='innovation.currentVersion.name + ".json"' v-bind:href='innovation.results.JSON').InnovationCard-download JSON
        a(v-bind:download='innovation.currentVersion.name + ".csv"' v-bind:href='innovation.results.CSV').InnovationCard-download CSV
        a(v-bind:download='innovation.currentVersion.name + ".json"' v-bind:href='innovation.results.raw').InnovationCard-download raw
      .InnovationCard-title {{innovation.currentVersion.name}}
      // .InnovationCard-badge
      // .InnovationCard-ribbon
      .InnovationCard-preview(v-link='{ path: "/edit/" + innovation.currentVersion.ID + "/" + innovation.currentVersion.slug}')

</template>

<script lang="coffee">
innovationDefaults = require '../resources/innovation'
utils = require '../utilities'
slug = utils.slug

getResults = require('../utilities').getResults


DB = window.localStorageDB


module.exports =


  data: ->

    # initialize Database

    @db = DB 'innovant', localStorage

    if !@db.tableExists 'innovations'
      @db.createTable 'innovations', ['versions']

    if !@db.tableExists 'innovationVersions'
      @db.createTable 'innovationVersions', ['name', 'description', 'font', 'published', 'colors', 'modules', ]

    if !@db.tableExists 'results'
      @db.createTable 'results', ['innovationVersionID', 'sessionID', 'results']

      # insert triton
      newInnovation = innovationDefaults.templates.triton()
      versionId = @db.insert 'innovationVersions', newInnovation
      @db.insert 'innovations',
        versions: [versionId]

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
        innovation.results = getResults @db, currentVersionId
      innovations
    return {innovations: @getInnovationsFromDB()}

  methods:

    # read innovation template and insert it into database
    createInnovation: ->
      newInnovation = innovationDefaults.templates.empty()
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
