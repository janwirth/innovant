<template lang="jade">
.Editor

  View(v-bind:innovation='innovation')

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
innovationDefaults = require '../../resources/innovation'
innovationModules = require '../../resources/modules'
fonts = require '../../resources/fonts'
DataHelper = require('../../utilities').DataHelper
getResults = require('../../utilities').getResults

DB = window.localStorageDB

db = null


module.exports =
  data: ->
    # init DB with each load of component
    db =  DB 'innovant', localStorage
    currentVersion = db.queryAll('innovationVersions', {query: {ID: @$route.params.ID}})[0]

    results = getResults(db, @$route.params.ID)

    data =
      fonts: fonts

      innovation: currentVersion
      innovationModules: innovationModules
      versionID: currentVersion.ID # hack: localStorageDB deletes the in-storage the id on update...
      results: results
      viewUrl: '/#!/' + currentVersion.ID + '/' + currentVersion.slug
    console.log data
    return data

  methods:
    publish: ->
      @innovation.published = true
      db.update 'innovationVersions', {ID: @versionID}, (row) =>
        @innovation
      db.commit()

  components:
    View: require './view.vue'

  directives:
    medium: require '../../directives/medium'

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
