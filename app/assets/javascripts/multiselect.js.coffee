$(document).on 'ready page:load', ->
  $('.selector').multiselect({
    enableFiltering: true,
    nonSelectedText: 'Нічого не обрано',
    numberDisplayed: 10,
    nSelectedText: 'обрано',
    filterPlaceholder: 'Пошук',
    selectAllText: 'Обрати все',
    includeSelectAllOption: true,
    maxHeight: 200
  });