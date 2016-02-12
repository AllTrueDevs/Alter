hide_flash = setTimeout ->
  $('.alert').fadeOut(2000)
, 3500

$ ->
  hide = setTimeout ->
    $('.alert').fadeOut(2000)
  , 2000

  $('.alert').on 'mouseover', (e) ->
    clearTimeout(hide)
    $(this).stop().animate({opacity: '100'})

  $('.alert').on 'mouseout', (e) ->
    hide = hide_flash