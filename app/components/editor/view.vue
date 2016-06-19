<template lang="jade">
  .Editor-view
    link(v-bind:href='innovation.font.url' rel='stylesheet' type='text/css')

    .DropZone(v-dropzone:module="insertModule($dropdata.module, 0)")
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

            img(v-bind:src='value' v-if='type == "Image"').Image

            .Table-wrap(v-if='type == "Table"')
              | {{{value}}}

          .Module-text(v-bind:style='{background: innovation.colors.background}')
            div(v-for='(type, value) in module.content' class='{{type}}')

              .Heading-wrap(v-if='type == "Heading"')
                h1.Heading(v-medium='value')

              .Text-wrap(v-if='type == "Text"')
                p.Text(v-medium='value')

          .Module-cards
            div(v-for='(type, value) in module.content' class='{{type}}')
              .Prices-wrap(v-if='type == "Prices"') 
                .Card(v-for='price in value')
                  .Card-title(v-medium='price.title')
                  .Card-value(v-medium='price.cost')
    

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

</script>
