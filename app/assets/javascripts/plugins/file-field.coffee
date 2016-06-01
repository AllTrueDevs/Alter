$ ->
  $(":file").filestyle({
    buttonText: 'Файл',
    iconName: "fa fa-download"
  })

  $('.bootstrap-filestyle input').prop(placeholder: 'Оберіть файл')

  $('.bootstrap-filestyle input').on 'change', (e) ->
    if this.val().length == 0
      this.prop(placeholder: 'Оберіть файл')
