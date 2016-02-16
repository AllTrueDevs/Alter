$(window).on 'load', ->
  setTimeout ->
    scrollTo(0,0)
  , 100

$ ->
  $('body').on 'mousewheel', (e) ->
    if e.target.id == 'el'
      return
    e.preventDefault()
    e.stopPropagation()

  setTimeout ->
    $('body').unbind('mousewheel');
    $('#preload').remove()
  , 1000

