(function() {
  $(function() {
    return $('.tags-field').selectize({
      delimiter: ',',
      persist: false,
      create: function(input) {
        return {
          value: input,
          text: input
        };
      }
    });
  });

}).call(this);
