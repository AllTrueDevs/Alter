$ ->
  $('.count').TouchSpin({
    verticalbuttons: true,
    initval: 1,
    min: 1,
    max: 1000000000,
    boostat: 5,
    maxboostedstep: 1000
  })
  select = $('.category').selectize({
    sortField: 'text'
  })

  $('.new_request .remove_nested_fields').prop('disabled', true)

  $(document).on 'nested:fieldAdded', (event) ->
    field = event.field
    $('.new_request .remove_nested_fields').prop('disabled', false)
    field.find('.count').TouchSpin({
      verticalbuttons: true,
      initval: 1,
      min: 1,
      max: 1000000000,
      boostat: 5,
      maxboostedstep: 1000
    })
    field.find('.category').selectize({
      sortField: 'text'
    });

  $(document).on 'nested:fieldRemoved', ->
    $('.new_request .fields:hidden').remove()
    if $('.new_request .fields').length == 1
      $('.new_request .remove_nested_fields').prop('disabled', true)
