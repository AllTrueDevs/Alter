(function() {
  $(function() {
    var select;
    $('.count').each(function() {
      var max, min, state;
      max = parseInt($(this).data('max'));
      min = parseInt($(this).data('min'));
      state = $(this).closest('.right-side').siblings('.cute-select:disabled').length !== 0;
      if (state) {
        $(this).parent().siblings('a').prop('disabled', true);
      }
      return $(this).TouchSpin({
        verticalbuttons: true,
        verticalupclass: 'fa fa-chevron-up',
        verticaldownclass: 'fa fa-chevron-down',
        initval: 1,
        min: min,
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
      $('.item-form#new_request .remove_nested_fields').prop('disabled', false);
      field.find('.count').TouchSpin({
        verticalbuttons: true,
        verticalupclass: 'fa fa-chevron-up',
        verticaldownclass: 'fa fa-chevron-down',
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
    $(document).on('change', '.cute-select', function() {
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
    return $('.item-form').on('submit', function() {
      return $('.cute-select:disabled').prop('disabled', false);
    });
  });

}).call(this);
