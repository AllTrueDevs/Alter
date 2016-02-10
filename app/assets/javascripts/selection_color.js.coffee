$('select').on 'change', (e) ->
  example = $(this).parent().find('div')
  example.attr('class', '#modal-color div')
  example.addClass('label-' + this.value)

