$ ->
  $(document).on 'nested:fieldRemoved', ->
    $('.message-form .fields:hidden').each ->
      $(this).remove()
    if $('.message-form .fields').length == 4
     $('.message-form .add_nested_fields').prop('disabled', false)

  $(document).on 'nested:fieldAdded', ->
    if $('.message-form .fields').length == 5
      $('.message-form .add_nested_fields').prop('disabled', true)

    $(":file").filestyle({
      buttonText: 'Прикріпити',
      buttonBefore: true
    })

    $('.bootstrap-filestyle input').prop(placeholder: 'Файл не обрано')

    $('.bootstrap-filestyle input').on 'change', (e) ->
      if this.val().length == 0
        this.prop(placeholder: 'Файл не обрано')