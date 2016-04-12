(function() {
  $(document).on('change', 'select', function() {
    var example;
    example = $(this).parent().find('div');
    example.attr('class', '');
    return example.addClass('label-' + this.value);
  });

}).call(this);
