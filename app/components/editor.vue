<template lang="jade">
.Editor
  .Editor-view

    template(v-for='module in innovation.modules')

      section.Module(class='Module--{{module.type}}' v-bind:style='{background: innovation.colors.background, \
        color: innovation.colors.text,\
        "border-color": innovation.colors.text}')

        .DropZone(v-dropzone:module="insertModule($dropdata.module, $index)")
        button(v-on:click='removeModule(innovation, module)').Innovation-removeModule
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
        button(v-on:click='toggleAnalytics(innovation, module)').Innovation-toggleAnalytics Fragen ein- oder ausschalten


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

      section.Module.Module--hero
        .DropZone(v-dropzone:module="insertModule($dropdata.module, innovation.modules.length)")

  .EditorToolbar
    .InnovationInfo
      h1(v-medium='innovation.name' mode='inline').InnovationInfo-title
      p(v-medium='innovation.description' mode='partial').InnovationInfo-description
      p(v-if='innovation.published').InnovationInfo-description Publiziert und schreibgeschützt
      button(v-on:click='publish()' v-if='!innovation.published').PublishButton Publizieren

    .EditorState
      div(v-if='!innovation.published').EditorState-tab.is-active Entwickeln
      div(v-if='innovation.published').EditorState-tab Analyse

    .Editor-colorPanel(v-if='!innovation.published')
      .Editor-colorInput
        label.EditorToolbar-label Hintergrundfarbe
        input(type='color' v-model='innovation.colors.background').Editor-colorInput
      .Editor-colorInput
        label.EditorToolbar-label Textfarbe
        input(type='color' v-model='innovation.colors.text').Editor-colorInput

    div(v-if='!innovation.published').Editor-modulePanel
      .ModuleSection(v-for='(name, modules) in innovationModules')
        .ModuleSection-heading {{name}}
        .ModuleSection-modules
          .ModuleTemplate(v-for='module in modules' v-draggable:module="{module: module, index: $index}")

    div(v-if='innovation.published').Editor-analysisPanel
      a(v-bind:href='viewUrl').EditorToolbar-button Umfrage zeigen
      a(v-bind:download='innovation.name + ".json"' v-bind:href='resultsJSON').EditorToolbar-button Ergebnisse Herunterladen
</template>



<script lang="coffee">
innovationDefaults = require '../resources/demoInnovation.coffee'
innovationModules = require '../resources/modules.coffee'

DB = window.localStorageDB

db = null

formatResults = (results) ->
  results

convertToURI = (data) ->
  "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(data))

module.exports =
  data: ->
    # init DB with each load of component
    db =  DB 'innovant', localStorage
    currentVersion = db.queryAll('innovationVersions', {query: {ID: @$route.params.ID}})[0]

    rawResults = db.queryAll('results', {query: {innovationVersion: @$route.params.ID}})


    data =
      defaults:
        inputs: innovationDefaults.inputs
        modules: innovationDefaults.modules
      innovation: currentVersion
      innovationModules: innovationModules
      versionID: currentVersion.ID # hack: localStorageDB screws up the id on update...
      resultsJSON: convertToURI formatResults rawResults
      viewUrl: '/#!/' + currentVersion.ID + '/' + currentVersion.slug
    return data

  methods:
    insertModule: (module, index) ->
      console.log module, index
      @innovation.modules.splice index, 0, module

    addInput: (module, input) ->
      module.analytics.inputs.push input()

    toggleAnalytics: (innovation, module) ->
      module.analytics.active = !module.analytics.active

    removeInput: (module, input) ->
      module.analytics.inputs.$remove input

    removeModule: (innovation, module) ->
      innovation.modules.$remove module

    publish: ->
      @innovation.published = true
      console.log @innovation, @versionID
      db.update 'innovationVersions', {ID: @versionID}, (row) =>
        @innovation
      db.commit()


  directives:
    medium: require '../directives/medium'

  watch:
    innovation:
      deep: true
      handler: (newState, oldState) ->
        if !@innovation.published
          db.update 'innovationVersions', {ID: @versionID}, (row) ->
            newState
          db.commit()
</script>
