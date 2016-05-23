<template lang="jade">
pre {{innovation | json}}
.hack(v-for='innovation in innovation')
  .Editor
    .Editor-view(v-on:click='showData')
      section(v-for='module in innovation.modules' class='Module--{{module.type}}').Module
        .Module-content
          // render each content bit
          div(v-for='(type, value) in module.content' class='{{type}}')

            .Heading-wrap(v-if='type == "Heading"')
              h1.Heading(v-medium='value')
              input(v-model='value')

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

    .Editor-toolbar
      h1(v-medium='innovation.name' mode='inline')
</template>



<script lang="coffee">

db = require('../firebase.coffee')()

module.exports =

  firebase: ->
    data = 
      innovation:
        source: db.innovation @$route.params.innovation_slug

  directives:
    medium: require '../directives/medium'

</script>
