$(".request-index").fadeOut(400, function() {
    $('.request-index').html("<%= escape_javascript(render partial: 'requests/requests_list', locals: { requests: @requests }) %>").fadeIn(200);
});