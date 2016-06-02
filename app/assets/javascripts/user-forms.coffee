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
          suggestion: (settlements) ->
            type = if settlements.type != 'місто' then "#{settlements.type} " else ''
            region = if settlements.region.length != 0 then "#{settlements.region}, " else ''
            return "<p>#{type}#{settlements.settlement}, #{region}#{settlements.district}</p>"
        limit: 10
      }
    )
    .on 'typeahead:select', (event, suggestion) ->
      if suggestion.region.length == 0
        region = suggestion.district
        district = suggestion.region
      else
        region = suggestion.region
        district = suggestion.district
      $(this).closest('form').find('.region').val(region).removeClass('hidden')
      $(this).closest('form').find('.district').val(district).removeClass('hidden')
      $(this).closest('form').find('.settlement-type').val(suggestion.type)
    .on 'focusout', ->
      if $(this).siblings().find('.tt-suggestion').length == 0 || $(this).val().length == 0
        $(this).typeahead('val','')
        $(this).closest('form').find('.settlement-type').val('')
        $(this).closest('form').find('.region').val('').addClass('hidden')
        $(this).closest('form').find('.district').val('')

  $('.user-form').on 'submit', ->
    $('.region:disabled').prop('disabled', false)
