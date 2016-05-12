<template lang="jade">
section(v-for='module in innovation.modules' class='Module--{{module.type}}').Module
  .Module-content
    // render each content bit
    div(v-for='(type, value) in module.content' class='{{type}}')

      .Heading-wrap(v-if='type == "Heading"')
        h1.Heading(v-medium='value')

      .Text-wrap(v-if='type == "Text"')
        p.Text(v-medium='value')

      .Image-wrap(v-if='type == "Image"')
        img(v-bind:src='value').Image

      .Table-wrap(v-if='type == "Table"')
        {{{value}}}


  // render question
  .Module-analytics(v-if='module.analytics.active')
    .Question
      .Question-text {{module.analytics.question.text}}
      .Question-explanation {{module.analytics.question.explanation}}

    div(v-if='module.analytics.scale.type == "analog"' class='Input--analog')
      .Input-labelLow {{module.analytics.scale.labelLow}}
      input(type='range').Input-element
      .Input-labelHigh {{module.analytics.scale.labelHigh}}
</template>



<script lang="coffee">
DB = require '../localStorageDB.js'

saveInnovation = (newState, oldState) ->
  db =  DB 'innovant', localStorage
  db.update 'innovationVersions', {_id: oldState._id}, (row) -> 
    newState
  db.commit()

module.exports =
  data: ->
    db =  DB 'innovant', localStorage
    currentVersion = db.queryAll('innovationVersions', {query: {_id: @$route.params._id}})[0]
    data = 
      innovation: currentVersion
    return data
  directives:
    medium: require '../directives/medium'
  watch:
    innovation:
      handler: saveInnovation
      deep: true
</script>
