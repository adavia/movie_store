window.JS ||= {}

JS.init = ->
  $(document).foundation();

$(document).on "turbolinks:load", ->
  JS.init()
