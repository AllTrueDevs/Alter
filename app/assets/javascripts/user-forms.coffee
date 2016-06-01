$ ->
  $('.error').removeClass('error', 2000)
  $('#user_phone').mask('+38(099)999-99-99', { placeholder: '_' })

  $('.autocomplete').each ->
    numbers = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace($(this).data('autocomplete-search'))
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: {
        url: $(this).data('autocomplete-url'),
        wildcard: '_QUERY_',
      },
      identify: (obj)-> obj.id
    )

    numbers.initialize()

    $(this).typeahead(
      {
        minLength: 0,
        hint: true,
        highlight: true
      },
      {
        displayKey: $(this).data('autocomplete-search')
        source: numbers.ttAdapter(),
        templates:
          suggestion: (cities) ->
            type = if cities.type != 'місто' then "#{cities.type} " else ''
            region = if cities.region.length != 0 then "#{cities.region}, " else ''
            return "<p>#{type}#{cities.city}, #{region}#{cities.district}</p>"
        limit: 10
      }
    )
    .on 'typeahead:select', (event, suggestion) ->
      region = if suggestion.region.length == 0 then suggestion.district else suggestion.region
      $(this).closest('form').find('.region').val(region).show()
    .on 'focusout', ->
      if $(this).siblings().find('.tt-suggestion').length == 0 || $(this).val().length == 0
        $(this).typeahead('val','')
        region = $(this).closest('form').find('.region')
        region.val('').hide()
