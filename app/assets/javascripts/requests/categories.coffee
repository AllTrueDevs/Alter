$ ->
  if  $('#categories option:selected').length > 0
    $('#categories > option:selected').each ->
      $('.categories-labels').append(form_string(@value, @text))

  $('#categories').multiselect
    enableFiltering: true
    filterPlaceholder: 'Пошук'
    includeSelectAllOption: true
    selectAllText: 'Обрати всі'
    maxHeight: 200
    buttonText: (options, select) ->
      'Оберіть категорії'
    onChange: (element, checked) ->
      if checked == true
        if element == undefined
          $('.label').remove()
          $('#categories > option').each ->
            $('.categories-labels').append(form_string(@value, @text))
        else
          $('.categories-labels').append(form_string(element.prop('value'), element.prop('text')))
      else
        if element == undefined
          $('.label').remove()
        else
          $('.category-' + element.prop('value').split('::')[0]).remove()

form_string = (value, text) ->
  """
    <span class="label category-#{value.split('::')[0]}" style="background: ##{value.split('::')[1]}">#{text}</span>
  """