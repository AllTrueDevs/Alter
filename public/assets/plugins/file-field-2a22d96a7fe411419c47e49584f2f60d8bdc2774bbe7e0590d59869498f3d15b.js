(function() {
  $(function() {
    $(":file").filestyle({
      buttonText: 'Файл',
      iconName: "fa fa-download"
    });
    $('.bootstrap-filestyle input').prop({
      placeholder: 'Оберіть файл'
    });
    return $('.bootstrap-filestyle input').on('change', function(e) {
      if (this.val().length === 0) {
        return this.prop({
          placeholder: 'Оберіть файл'
        });
      }
    });
  });

}).call(this);
