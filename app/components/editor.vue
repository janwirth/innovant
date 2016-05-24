<template lang="jade">
.Editor
  .Editor-view
    section(v-for='module in innovation.modules' class='Module--{{module.type}}').Module
      button(v-on:click='removeModule(innovation, module)').Innovation-removeModule x
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
            button(v-on:click='removeInput(module, input)').Module-removeInput x

          div(v-if='input.type == "textarea"' class='Input--{{input.type}}')
            .Input-label(v-medium='input.label')
            textarea.Input-element
            button(v-on:click='removeInput(module, input)').Module-removeInput x

        template(v-for='input in defaults.inputs')
          button(v-on:click='addInput(module, input)').Module-addInput Add {{$key}} field

    template(v-for='module in defaults.modules')
      button(v-on:click='addModule(innovation, module)').Innovation-addModule Add {{$key}} module

  .Editor-toolbar
    h1(v-medium='innovation.name' mode='inline')
</template>



<script lang="coffee">
innovationDefaults = require '../resources/demoInnovation.coffee'
DB = window.localStorageDB
console.log innovationDefaults

db = null

module.exports =
  data: ->
    # init DB with each load of component
    db =  DB 'innovant', localStorage
    currentVersion = db.queryAll('innovationVersions', {query: {ID: @$route.params.ID}})[0]

    data = 
      defaults:
        inputs: innovationDefaults.inputs
        modules: innovationDefaults.modules
      innovation: currentVersion
      versionID: currentVersion.ID # hack: localStorageDB screws up the id on update...
    return data

  methods:
    addModule: (innovation, module) ->
      innovation.modules.push module()

    addInput: (module, input) ->
      module.analytics.inputs.push input()

    removeInput: (module, input) ->
      module.analytics.inputs.$remove input

    removeModule: (innovation, module) ->
      innovation.modules.$remove module


  directives:
    medium: require '../directives/medium'

  watch:
    innovation:
      deep: true
      handler: (newState, oldState) ->
        db.update 'innovationVersions', {ID: @versionID}, (row) -> 
          newState
        db.commit()
</script>
