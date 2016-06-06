<template lang="jade">
header.Header
  .Header-titleSection
    a(href='#!').HeaderLogo
      img(src='img/logo.png' alt='Innovant Logo').HeaderLogo-image

    .HeaderTitle: span {{$route.title}}

  .Header-profileSection

    .Notifications(v-bind:class='{"is-new": notifications.length > 0}')
      .Notifications-icon
      .Notifications-counter {{notifications.length}}

    .AccountButton(v-on:click='toggleDropdown("account")')

    .AccountDropdown(v-bind:class='{"is-expanded": dropdowns.account}')
      .AccountDropdownProfile
        .AccountDropdownProfile-portrait
        .AccountDropdownProfile-name Daniel Tress

      ul.AccountDropdown-options
        li.DropdownOption
          a(href='#')
            span.DropdownOption-title Profil Bearbeiten
            span.DropdownOption-icon
        li.DropdownOption
          a(href='#')
            span.DropdownOption-title Support
            span.DropdownOption-icon
        li.DropdownOption
          a(href='#')
            span.DropdownOption-title Passwort Ändern
            span.DropdownOption-icon
        li.DropdownOption
          a(href='#')
            span.DropdownOption-title Abmelden
            span.DropdownOption-icon
.HeaderSpacer

</template>

<script lang="coffee">
module.exports =
  data: ->
    dropdowns: 
      account: false
    notifications: ['a', 'b', 'c']
  methods:
    toggleDropdown: (type) ->
      @dropdowns[type] = !@dropdowns[type]

</script>
