$ ->
  $('.nav-tabs a').click ->
    $('ul.nav-tabs li.active').removeClass('active')
    $(this).parent('li').addClass('active')