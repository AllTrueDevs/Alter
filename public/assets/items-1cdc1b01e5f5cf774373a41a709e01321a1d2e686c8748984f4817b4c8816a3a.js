(function() {
  $(function() {
    var select;
    $('.count').each(function() {
      var max;
      max = parseInt($(this).data('max'));
      return $(this).TouchSpin({
        verticalbuttons: true,
        verticalupclass: 'glyphicon glyphicon-plus',
        verticaldownclass: 'glyphicon glyphicon-minus',
        initval: 1,
        min: 1,
        max: max,
        mousewheel: true,
        boostat: 5,
        maxboostedstep: 1000
      });
    });
    select = $('.cute-select').selectize({
      sortField: 'text'
    });
    if ($('.item-form .fields').length === 1) {
      $('.item-form .remove_nested_fields').prop('disabled', true);
    }
    $('.item-form').on('nested:fieldAdded', function(event) {
      var field;
      field = event.field;
      $('.item-form .remove_nested_fields').prop('disabled', false);
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
      });
      return field.find('.cute-select').selectize({
        sortField: 'text'
      });
    });
    $('.item-form').on('nested:fieldRemoved', function() {
      $('.item-form .fields:hidden').remove();
      if ($('.item-form .fields').length === 1) {
        return $('.item-form .remove_nested_fields').prop('disabled', true);
      }
    });
    return $(document).on('change', '.cute-select', function() {
      var url;
      if ($(this).val() !== '') {
        url = $(this).closest('.item-form').data('url');
        url = url + "&id=" + ($(this).val());
        return $.ajax({
          url: url,
          type: 'GET',
          dataType: 'script'
        });
      }
    });
  });

}).call(this);
