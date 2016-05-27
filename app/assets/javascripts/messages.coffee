$ ->
  if $('.dialog').length != 0 && $('.pagination-info').length != 0
    setTopInfiniteLoader()

  $('.dialog #message_body').on 'keydown', (event) ->
     if event.keyCode == 13 && !(event.shiftKey)
       event.preventDefault()
       $(this).closest('form').submit()
       $(this).val('').focus()

  $('.dialog .message-form').on 'click', (event) ->
    url = $(this).find('#message_body').data('url')
    $('.sent.new').addClass('m')
    $.ajax
      url: url
      type: 'GET'
      dataType: 'script'
      error: ->
        $('.m').removeClass('m')

  $('.message-form input[type=submit]').on 'click', (event) ->
    event.preventDefault()
    $(this).closest('form').submit()
    $('#message_body').val('').focus()

  $(document).on 'click', '.submit', ->
    $(this).removeClass('.active')
    $(this).closest('form').submit()

  $(document).on 'change', 'input[type=checkbox]', ->
    if $('input[type=checkbox]:checked').length == 0
      $('.submit-container').addClass('disabled')
      $('.submit-container a').removeClass('submit')
    else
      $('.submit-container').removeClass('disabled')
      $('.submit-container a').addClass('submit')

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
