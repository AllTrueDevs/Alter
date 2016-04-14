(function() {
  $(function() {
    return $('.news-circles').hover((function() {
      $('.news-circles').css('animation-play-state', 'paused');
      $('.news .title').html($(this).data('title'));
      return $('.news .description').html($(this).data('description'));
    }), function() {
      return $('.news-circles').css('animation-play-state', 'running');
    });
  });

}).call(this);
