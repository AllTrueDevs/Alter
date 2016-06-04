(function() {
  $(window).on('load', function() {
    return setTimeout(function() {
      return scrollTo(0, 0);
    }, 100);
  });

  $(function() {
    $('body').css('overflow-y', 'hidden');
    $('body').on('mousewheel', function(e) {
      if (e.target.id === 'el') {
        return;
      }
      e.preventDefault();
      return e.stopPropagation();
    });
    return setTimeout(function() {
      $('body').css('overflow-y', 'scroll');
      $('body').unbind('mousewheel');
      return $('#preload').remove();
    }, 1000);
  });

}).call(this);
