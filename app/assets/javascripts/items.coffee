$ ->
  $('.count').each ->
    max = parseInt($(this).data('max'))
    state = $(this).closest('.right-side').siblings(".cute-select:disabled").length != 0
    $(this).parent().siblings('a').prop('disabled', true) if state
    $(this).TouchSpin({
      verticalbuttons: true,
      verticalupclass: 'glyphicon glyphicon-plus',
      verticaldownclass: 'glyphicon glyphicon-minus',
      initval: 1,
      min: 1,
      max: max,
      mousewheel: true,
      boostat: 5,
      maxboostedstep: 1000
    })

  select = $('.cute-select').selectize({
    sortField: 'text'
  })

  if $('.item-form .fields').length == 1
    $('.item-form .remove_nested_fields').prop('disabled', true)

  $('.item-form').on 'nested:fieldAdded', (event) ->
    field = event.field
    $('.item-form#new_request .remove_nested_fields').prop('disabled', false)
    field.find('.count').TouchSpin({
      verticalbuttons: true,
      verticalupclass: 'glyphicon glyphicon-plus',
      verticaldownclass: 'glyphicon glyphicon-minus',
      initval: 1,
      min: 1,
      max: 1,
      mousewheel: true,
      boostat: 5,
      maxboostedstep: 1000
    })
    field.find('.cute-select').selectize({
      sortField: 'text'
    });

  $('.item-form').on 'nested:fieldRemoved', ->
    $('.item-form .fields:hidden').remove()
    if $('.item-form .fields').length == 1
      $('.item-form .remove_nested_fields').prop('disabled', true)

  $(document).on 'change', '.cute-select', ->
    unless $(this).val() == ''
      url = $(this).closest('.item-form').data('url')
      url = "#{url}&id=#{$(this).val()}"
      $.ajax
        url: url
        type: 'GET'
        dataType: 'script'
