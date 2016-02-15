(function() {
  $('select').on('change', function(e) {
    var example;
    example = $(this).parent().find('div');
    example.attr('class', '#modal-color div');
    return example.addClass('label-' + this.value);
  });

}).call(this);
