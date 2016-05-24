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

DB = window.localStorageDB


module.exports =

  data: ->
    @db = DB 'innovant', localStorage

    if !@db.tableExists 'innovations'
      @db.createTable 'innovations', ['versions']

    if !@db.tableExists 'innovationVersions'
      @db.createTable 'innovationVersions', ['name', 'modules']

    @db.commit()

    @getInnovationsFromDB = =>
      innovations = @db.queryAll 'innovations'
      for innovation in innovations
        currentVersionId = innovation.versions[0]
        innovationVersions = @db.queryAll 'innovationVersions',
          query:
            ID: currentVersionId
        innovation.currentVersion = innovationVersions[0]
        innovation.currentVersion.slug = slug innovation.currentVersion.name
      innovations
    return {innovations: @getInnovationsFromDB()}

  methods:
    createInnovation: ->
      newInnovation = demoInnovation.complete()
      versionId = @db.insert 'innovationVersions', newInnovation
      @db.insert 'innovations',
        versions: [versionId]
      @db.commit()
      @innovations = @getInnovationsFromDB()

    clearInnovations: ->
      @db.deleteRows 'innovations'
      @db.deleteRows 'innovationVersions'
      @db.commit()
      @innovations = @getInnovationsFromDB()

</script>
