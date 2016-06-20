<template lang="jade">
.Analysis
  .Analysis-tabs
    .Tab(v-on:click='setSection("general")' v-bind:class='{"is-active": currentSection == "general"}') Übersicht
    .Tab(v-on:click='setSection("details")' v-bind:class='{"is-active": currentSection == "details"}') Details
    .Tab(v-on:click='setSection("compare")' v-bind:class='{"is-active": currentSection == "compare"}') Vergleich

  .Analysis-section
    .Analysis-slide(v-for='slide in sections[currentSection].slides' v-show='sections[currentSection].currentSlide == $index')
      img(v-bind:src='"img/analysis/" + slide'  v-on:click='next(sections[currentSection])')
  

</template>

<script lang='coffee'>

module.exports =
  data: ->
    data =

        currentSection: 'general'
        sections:
          general:
            currentSlide: 0
            slides: [
              '01_uebersicht.png'
            ]
            sidebar: '01_uebersicht_sidebar.png'

          details:
            currentSlide: 0
            slides: [
              '02_details.png'
              '03_beschriftung_absolut.png'
              '04_beschriftung_Konfidenzen.png'
              '05_boxplot.png'
              '06_semantisches_diff.png'
              '07_semantisches_diff_absolut.png'
              '08_zurück_zu_säulen.png'
              '09_usp_features_ausklappen.png'
              '10_usp_features_wieder_zuklappen.png'
              '11_Filter_Dropdown.png'
              '12_Filter_männlich.png'
              '13_Vergleich_Dropdown.png'
              '14_Vergleich_zweiAltersgruppen.png'
            ]
            sidebar: '02_details_sidebar.png'

          compare:
            currentSlide: 0
            slides: [
              '15_Landingpage-vergleich.png'
              '15_Landingpage-vergleich1.png'
              '15_Landingpage-vergleich2.png'
              '16_Landingpage-vergleich_auswahl.png'
            ]

  methods:
    next: (section) ->
      console.log section.slides.length, section.currentSlide
      if section.slides.length - 1 > section.currentSlide
        section.currentSlide++
      else
        console.log 'last slide reached'

    setSection: (id) ->
      @currentSection = id
      @sections[id].currentSlide = 0

    last: ->
      @currentSlide--

</script>
