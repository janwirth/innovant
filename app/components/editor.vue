<template lang="jade">
.Editor
  .Editor-view
    link(v-bind:href='innovation.font.url' rel='stylesheet' type='text/css')

    template(v-for='module in innovation.modules')

      section.Module(class='Module--{{module.type}}' v-bind:style='{background: innovation.colors.background, \
        color: innovation.colors.text,\
        "font-family": innovation.font.name,\
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

    a(v-bind:href='viewUrl' target='_blank' v-if='innovation.published').Button--showSurvey Umfrage zeigen

    .EditorState
      div(v-if='!innovation.published').EditorState-tab.is-active Entwickeln
      div(v-if='innovation.published').EditorState-tab Analyse

    .Editor-fontPanel(v-if='!innovation.published')
      .Editor-colorInput
        label.EditorToolbar-label Schriftart


        select.form-control(name='template', v-model='innovation.font')
          option(v-for='font in fonts', v-bind:selected='font.name == innovation.font.name', v-bind:value='font')
            | {{font.name}}

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
      .EditorPanelHeading Ergebnisse Herunterladen
      a(v-bind:download='innovation.name + ".json"' v-bind:href='results.JSON').Button--resultsDownload JSONresults
      a(v-bind:download='innovation.name + ".csv"' v-bind:href='results.CSV').Button--resultsDownload CSV
      a(v-bind:download='innovation.name + ".csv"' v-bind:href='results.raw').Button--resultsDownload Rohdaten
</template>



<script lang="coffee">
innovationDefaults = require '../resources/demoInnovation'
innovationModules = require '../resources/modules'
fonts = require '../resources/fonts'
DataHelper = require('../utilities').DataHelper

DB = window.localStorageDB

db = null


module.exports =
  data: ->
    # init DB with each load of component
    db =  DB 'innovant', localStorage
    currentVersion = db.queryAll('innovationVersions', {query: {ID: @$route.params.ID}})[0]

    results = new DataHelper db.queryAll('results', {query: {innovationVersion: @$route.params.ID}})

    data =
      fonts: fonts

      defaults:
        inputs: innovationDefaults.inputs

      innovation: currentVersion
      innovationModules: innovationModules
      versionID: currentVersion.ID # hack: localStorageDB deletes the in-storage the id on update...
      results:
        JSON: results.toJsonString()
        CSV: results.toCsvString()
        raw:  results.getRaw()
      viewUrl: '/#!/' + currentVersion.ID + '/' + currentVersion.slug
    console.log data
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
            console.log 'updating'
            # newState.font.name = 'Helvetica'
            return newState
          console.log db.commit()
</script>
