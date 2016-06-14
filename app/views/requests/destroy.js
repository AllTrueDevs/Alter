$("#request-"+"<%= @request.id %>").fadeOut(function() {
    $(this).remove();
    if( $('.request').length === 0 ) {
        $('.request-index').append("<p class='nothing-to-show'> Запитів не знайдено</h5>");
        $('.pagination-info').remove();
    }
});
