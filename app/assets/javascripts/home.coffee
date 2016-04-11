$ ->
  $('.news-circles').hover (->
    $('.news-circles').css 'animation-play-state', 'paused'
    $('.news .title').html($(this).data('title'))
    $('.news .description').html($(this).data('description'))
  ), ->
    $('.news-circles').css 'animation-play-state', 'running'

