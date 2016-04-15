$ ->
  $('.news-circles').each ->
    $(this).addClass('hidden') if $(this).attr('href') == '#'
  $('.news-circles').delay(250).fadeIn()
  $('.news').delay(550).fadeIn 'slow'
  $('.news-circles').hover (->
    $('.news-circles').css 'animation-play-state', 'paused'
    $('.news .title').html($(this).data('title'))
    $('.news .description').html($(this).data('description'))
  ), ->
    $('.news-circles').css 'animation-play-state', 'running'


