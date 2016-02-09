(function() {
  $(function() {});

  $('.selector').multiselect({
    enableFiltering: true,
    nonSelectedText: 'Нічого не обрано',
    numberDisplayed: 10,
    nSelectedText: 'обрано',
    filterPlaceholder: 'Пошук',
    selectAllText: 'Обрати всі',
    includeSelectAllOption: true,
    maxHeight: 200
  });

}).call(this);
