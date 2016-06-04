(function() {
  var form_string;

  $(function() {
    if ($('#categories option:selected').length > 0) {
      $('#categories > option:selected').each(function() {
        return $('.categories-labels').append(form_string(this.value, this.text));
      });
    }
    return $('#categories').multiselect({
      enableFiltering: true,
      filterPlaceholder: 'Пошук',
      includeSelectAllOption: true,
      selectAllText: 'Обрати всі',
      maxHeight: 200,
      buttonText: function(options, select) {
        return 'Оберіть категорії';
      },
      onChange: function(element, checked) {
        if (checked === true) {
          if (element === void 0) {
            $('.label').remove();
            return $('#categories > option').each(function() {
              return $('.categories-labels').append(form_string(this.value, this.text));
            });
          } else {
            return $('.categories-labels').append(form_string(element.prop('value'), element.prop('text')));
          }
        } else {
          if (element === void 0) {
            return $('.label').remove();
          } else {
            return $('.category-' + element.prop('value').split('::')[0]).remove();
          }
        }
      }
    });
  });

  form_string = function(value, text) {
    return "<span class=\"label category-" + (value.split('::')[0]) + "\" style=\"background: #" + (value.split('::')[1]) + "\">" + text + "</span>";
  };

}).call(this);
