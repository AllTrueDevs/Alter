$ ->
  $(this).find('.progress-bar').each ->
    $(this).animate { width: $(this).data('value') + '%' }, 500
  $('.percents').removeClass('hidden')
