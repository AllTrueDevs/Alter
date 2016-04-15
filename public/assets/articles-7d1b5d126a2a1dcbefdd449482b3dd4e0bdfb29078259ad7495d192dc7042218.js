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
(function() {
  $(function() {
    var i, len, ref, results, tag;
    ref = gon.default_tags_collection;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      tag = ref[i];
      results.push($('.tags-field')[0].selectize.addOption({
        value: tag,
        text: tag
      }));
    }
    return results;
  });

}).call(this);
