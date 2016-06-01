(function() {
  $(function() {
    return $('.nav-tabs a').click(function() {
      $('ul.nav-tabs li.active').removeClass('active');
      return $(this).parent('li').addClass('active');
    });
  });

}).call(this);
