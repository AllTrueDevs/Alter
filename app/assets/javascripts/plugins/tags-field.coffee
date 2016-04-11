$ ->
  $('.tags-field').selectize({
    delimiter: ',',
    persist: false,
    create: (input) ->
      return({
          value: input,
          text: input
    })
  })
