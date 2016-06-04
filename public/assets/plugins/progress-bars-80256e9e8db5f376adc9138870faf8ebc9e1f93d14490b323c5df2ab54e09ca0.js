(function() {
  $(function() {
    $(this).find('.progress-bar').each(function() {
      return $(this).animate({
        width: $(this).data('value') + '%'
      }, 500);
    });
    return $('.percents').removeClass('hidden');
  });

}).call(this);
