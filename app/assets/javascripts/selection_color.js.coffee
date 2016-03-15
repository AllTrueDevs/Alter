$(document).on 'change', 'select', ->
  example = $(this).parent().find('div')
  example.attr('class', '')
  example.addClass('label-' + this.value)

