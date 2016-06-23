<template lang="jade">
  .Editor-view
    link(v-bind:href='innovation.font.url' rel='stylesheet' type='text/css')
    .Note(v-if='innovation.modules.length == 0') Füge von rechts dein erstes Modul ein.


    .DropZone(v-dropzone:module="insertModule($dropdata.module, 0)")
    template(v-for='module in innovation.modules')

      section.Module(class='Module--{{module.type}}' v-bind:style='{background: innovation.colors.background, \
        color: innovation.colors.text,\
        "font-family": innovation.font.name,\
        "border-color": innovation.colors.text}')

        .DropZone(v-dropzone:module="insertModule($dropdata.module, $index)")
        button(v-on:click='removeModule(innovation, module)').Innovation-removeModule

        module-content(v-bind:module='module' v-bind:innovation='innovation')

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
              button(v-on:click='removeInput(module, input)').Module-removeInput

            div(v-if='input.type == "textarea"' class='Input--{{input.type}}')
              .Input-label(v-medium='input.label')
              textarea.Input-element
              button(v-on:click='removeInput(module, input)').Module-removeInput

          .Module-questionAdder: template(v-for='input in defaults.inputs')
            button(v-on:click='addInput(module, input)').Module-addInput {{input().name}} hinzufügen

      section.Module.Module--hero
        .DropZone(v-dropzone:module="insertModule($dropdata.module, innovation.modules.length)")

</template>

<script lang="coffee">
innovationDefaults = require '../../resources/innovation'

module.exports =

  props: ['innovation']

  data: ->
    defaults:
      inputs: innovationDefaults.inputs

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


  directives:
    medium: require '../../directives/medium'

  components:
    'ModuleContent': require '../moduleContent.vue'

</script>
