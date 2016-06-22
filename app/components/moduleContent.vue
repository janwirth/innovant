<template lang='jade'>
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
</template>

<script lang='coffee'>
module.exports =
  props: ['module', 'innovation']
  directives: 
    medium: require '../directives/medium'
</script>
