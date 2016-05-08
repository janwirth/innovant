<template lang="jade">
h1 Overview
.InnovationCard-wrap
  .InnovationCard(v-for='innovation in innovations' v-link='{ path: "/edit/" + innovation.currentVersion._id + "/" + innovation.currentVersion.slug}')
    .InnovationCard-Title {{innovation.currentVersion.name}}
</template>

<script lang="coffee">
demoInnovation = require './demoInnovation.coffee'

slug = require 'slug'

DB = require './localStorageDB.js'
db = DB 'innovant', localStorage

if db.isNew()
  db.createTable 'innovations', ['versions']
  db.createTable 'innovationVersions', ['_id', 'name', 'modules']

newInnovation = demoInnovation()
db.insert 'innovationVersions', newInnovation
db.insert 'innovations', 
  versions: JSON.stringify [newInnovation._id]
db.commit()

module.exports =
  data: ->
    innovations = db.queryAll 'innovations'
    for innovation in innovations
      currentVersionId = JSON.parse(innovation.versions)[0]
      innovationVersions = db.queryAll 'innovationVersions',
        query:
          _id: currentVersionId
      innovation.currentVersion = innovationVersions[0]
      innovation.currentVersion.slug = slug innovation.currentVersion.name
    return {innovations: innovations}
</script>
