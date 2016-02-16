$(window).on 'load', ->
  setTimeout ->
    scrollTo(0,0)
  , 100

$ ->
  $('body').css('overflow-y', 'hidden')
  $('body').on 'mousewheel', (e) ->
    if e.target.id == 'el'
      return
    e.preventDefault()
    e.stopPropagation()

  setTimeout ->
    $('body').css('overflow-y', 'scroll')
    $('body').unbind('mousewheel')
    $('#preload').remove()
  , 1000

