(function() {
  $(function() {
    if ($('.dialog').length !== 0) {
      setTopInfiniteLoader();
    }
    $(document).on('click', '.submit', function() {
      $(this).removeClass('.active');
      return $(this).closest('form').submit();
    });
    $(document).on('change', 'input[type=checkbox]', function() {
      if ($('input[type=checkbox]:checked').length === 0) {
        $('.submit-container').addClass('disabled');
        return $('.submit-container a').removeClass('submit');
      } else {
        $('.submit-container').removeClass('disabled');
        return $('.submit-container a').addClass('submit');
      }
    });
    $(document).on('nested:fieldRemoved', function() {
      $('.message-form .fields:hidden').each(function() {
        return $(this).remove();
      });
      if ($('.message-form .fields').length === 4) {
        return $('.message-form .add_nested_fields').prop('disabled', false);
      }
    });
    return $(document).on('nested:fieldAdded', function() {
      if ($('.message-form .fields').length === 5) {
        $('.message-form .add_nested_fields').prop('disabled', true);
      }
      $(":file").filestyle({
        buttonText: 'Прикріпити',
        buttonBefore: true
      });
      $('.bootstrap-filestyle input').prop({
        placeholder: 'Файл не обрано'
      });
      return $('.bootstrap-filestyle input').on('change', function(e) {
        if (this.val().length === 0) {
          return this.prop({
            placeholder: 'Файл не обрано'
          });
        }
      });
    });
  });

}).call(this);
