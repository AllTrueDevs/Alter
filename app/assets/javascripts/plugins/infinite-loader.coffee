$ ->
  window.infiniteToTop = ->
    if ($(window).scrollTop() < 20)
      if $('.loader').hasClass('hidden')
        $('.pagination-info').remove()
      else
        $(window).scrollTop($(window).scrollTop() + 200)
      $('.infinite').infinitePages('next') unless $('.pagination-info').length == 0

  window.setTopInfiniteLoader = ->
    $('.infinite').infinitePages('pause')
    debugger
    window.scrollTo(0,document.body.scrollHeight)

    $(window).on 'mousewheel', ->
      infiniteToTop()

    $(document).on 'scrollstart', ->
      infiniteToTop()

    $(document).on 'keydown', (e) ->
      if e.which == 33 || e.which == 38 || e.which == 36
        infiniteToTop()

  $('.infinite').infinitePages
    loading: ->
      $('.loader').addClass('hidden')
    success: ->
      $('.loader').removeClass('hidden')
    error: ->
      $(this).html('Виникла помилка. Перезавантажте будь ласка сторінку')
