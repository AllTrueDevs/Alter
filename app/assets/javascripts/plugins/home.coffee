$ ->
  $('.news').hover (->
    $('.circle').css 'animation-play-state', 'paused'
  ), ->
    $('.circle').css 'animation-play-state', 'running'

