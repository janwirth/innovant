<template lang="jade">
.Editor
  .Editor-view
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
            | {{{value}}}


      // render question
      .Module-analytics(v-if='module.analytics.active')
        .Question
          .Question-text(v-medium='module.analytics.question.text')
          .Question-explanation(v-medium='module.analytics.question.explanation')

        // render input fields
        template(v-for='input in module.analytics.inputs' )

          div(v-if='input.type == "range"' class='Input--{{input.type}}')
            .Input-labelLow(v-medium='input.label')
            input(type='range').Input-element
            .Input-labelHigh(v-medium='input.labelHigh')

          div(v-if='input.type == "textarea"' class='Input--{{input.type}}')
            .Input-label(v-medium='input.label')
            textarea.Input-element

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
