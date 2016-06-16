<template lang="jade">
.Viewer
    link(v-bind:href='innovation.font.url' rel='stylesheet' type='text/css')

    section.Module(v-for='module in innovation.modules' class='Module--{{module.type}}' v-bind:style='{background: innovation.colors.background,\
      color: innovation.colors.text,\
      "font-family": innovation.font.name,\
      "border-color": innovation.colors.text}')

      .Module-content
        // render each content bit
        div(v-for='(type, value) in module.content' class='{{type}}')

          .Heading-wrap(v-if='type == "Heading"')
            h1.Heading {{{value}}}

          .Text-wrap(v-if='type == "Text"')
            p.Text {{{value}}}

          .Image-wrap(v-if='type == "Image"')
            img(v-bind:src='value').Image

          .Table-wrap(v-if='type == "Table"')
            | {{{value}}}


      // render question
      .Module-analytics(v-if='module.analytics.active')
        .Question
          .Question-text {{{module.analytics.question.text}}}
          .Question-explanation {{{module.analytics.question.explanation}}}

        // render input fields
        template(v-for='input in result.results[$index].inputs' )

          div(v-if='input.type == "range"' class='Input--{{input.type}}')
            .Input-labelLow {{{input.label}}}
            input(type='range' v-model='input.value').Input-element
            .Input-labelHigh {{{input.labelHigh}}}

          div(v-if='input.type == "textarea"' class='Input--{{input.type}}')
            .Input-label {{{input.label}}}
            textarea(v-model='input.value').Input-element
</template>



<script lang="coffee">
innovationDefaults = require '../resources/innovation.coffee'

utils = require '../utilities'

DB = window.localStorageDB

db = null

module.exports =
  data: ->
    # init DB with each load of component

    db =  DB 'innovant', localStorage

    currentVersion = db.queryAll('innovationVersions', {query: {ID: @$route.params.ID}})[0]

    # prepare results data
    resultsData =
      innovationVersionID: currentVersion.ID
      sessionID: utils.id()
      results: []

    console.log currentVersion
    for module in currentVersion.modules
      resultsData.results.push module.analytics

    resultID = db.insert 'results', resultsData
    db.commit()


    result = db.queryAll('results', {query: {ID: resultID}})[0]
    console.log resultID
    console.log result

    data =
      innovation: currentVersion
      versionID: currentVersion.ID # hack: localStorageDB screws up the id on update
      result: result
      resultID: resultID
    return data

  methods:
    addModule: (innovation, module) ->
      innovation.modules.push module()


  directives:
    medium: require '../directives/medium'

  watch:
    result:
      deep: true
      handler: (newState, oldState) ->
        console.log newState
        db.update 'results', {ID: @resultID}, (row) ->
          newState
        db.commit()
</script>
