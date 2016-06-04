(function() {
  $(function() {
    $('.error').removeClass('error', 2000);
    $('#user_phone').mask('+38(099)999-99-99', {
      placeholder: '_'
    });
    $('.autocomplete').each(function() {
      var numbers;
      numbers = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace($(this).data('autocomplete-search')),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
          url: $(this).data('autocomplete-url'),
          wildcard: '_QUERY_'
        },
        identify: function(obj) {
          return obj.id;
        }
      });
      numbers.initialize();
      return $(this).typeahead({
        minLength: 0,
        hint: true,
        highlight: true
      }, {
        displayKey: $(this).data('autocomplete-search'),
        source: numbers.ttAdapter(),
        templates: {
          suggestion: function(settlements) {
            var region, type;
            type = settlements.type !== 'місто' ? settlements.type + " " : '';
            region = settlements.region.length !== 0 ? settlements.region + ", " : '';
            return "<p>" + type + settlements.settlement + ", " + region + settlements.district + "</p>";
          }
        },
        limit: 10
      }).on('typeahead:select', function(event, suggestion) {
        var district, region;
        if (suggestion.region.length === 0) {
          region = suggestion.district;
          district = suggestion.region;
        } else {
          region = suggestion.region;
          district = suggestion.district;
        }
        $(this).closest('form').find('.region').val(region).removeClass('hidden');
        $(this).closest('form').find('.district').val(district).removeClass('hidden');
        return $(this).closest('form').find('.settlement-type').val(suggestion.type);
      }).on('focusout', function() {
        if ($(this).siblings().find('.tt-suggestion').length === 0 || $(this).val().length === 0) {
          $(this).typeahead('val', '');
          $(this).closest('form').find('.settlement-type').val('');
          $(this).closest('form').find('.region').val('').addClass('hidden');
          return $(this).closest('form').find('.district').val('');
        }
      });
    });
    return $('.user-form').on('submit', function() {
      return $('.region:disabled').prop('disabled', false);
    });
  });

}).call(this);
