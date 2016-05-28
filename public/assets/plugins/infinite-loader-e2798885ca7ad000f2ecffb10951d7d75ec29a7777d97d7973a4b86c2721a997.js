(function() {
  $(function() {
    window.infiniteToTop = function() {
      if ($(window).scrollTop() < 20) {
        if ($('.loader').hasClass('hidden')) {
          $('.pagination-info').remove();
        } else {
          $(window).scrollTop($(window).scrollTop() + 200);
        }
        if ($('.pagination-info').length !== 0) {
          return $('.infinite').infinitePages('next');
        }
      }
    };
    window.setTopInfiniteLoader = function() {
      $('.infinite').infinitePages('pause');
      window.scrollTo(0, document.body.scrollHeight);
      $(window).on('mousewheel', function() {
        return infiniteToTop();
      });
      $(document).on('scrollstart', function() {
        return infiniteToTop();
      });
      return $(document).on('keydown', function(e) {
        if (e.which === 33 || e.which === 38 || e.which === 36) {
          return infiniteToTop();
        }
      });
    };
    return $('.infinite').infinitePages({
      loading: function() {
        return $('.loader').addClass('hidden');
      },
      success: function() {
        return $('.loader').removeClass('hidden');
      },
      error: function() {
        return $(this).html('Виникла помилка. Перезавантажте будь ласка сторінку');
      }
    });
  });

}).call(this);
