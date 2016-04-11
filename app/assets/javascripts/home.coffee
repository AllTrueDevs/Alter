$ ->
  $('.news-circles').hover (->
    $('.news-circles').css 'animation-play-state', 'paused'

    $('.news .title').html($(this).data('title'))
    $('.news .title').attr('title', $(this).data('title'))
  ), ->
    $('.news-circles').css 'animation-play-state', 'running'

