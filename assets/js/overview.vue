<template lang="jade">
h1 Overview
a(v-link='{ path: "/edit" }') Innovation
</template>

<script lang="coffee">
demoInnovation = require './demoInnovation.coffee'

DB = require './localStorageDB.js'
db = DB 'innovant', localStorage

if db.isNew
  db.createTable 'innovations', ['versions']
  db.createTable 'innovationVersions', ['_id', 'name', 'modules']

newInnovation = demoInnovation()
db.insert 'innovationVersions', newInnovation
db.insert 'innovations', 
  versions: JSON.stringify [newInnovation._id]

innovationVersions = db.queryAll 'innovationVersions'
console.log innovationVersions
innovations = db.queryAll 'innovations'
console.log innovations
</script>
