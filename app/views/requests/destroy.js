$("#request-"+"<%= @request.id %>").fadeOut(function() {
    $(this).remove();
    if( $('.request').length === 0 ) {
        $('.request-index').append("<h5 class='text-center'> Запитів не знайдено</h5>");
        $('.pagination-info').remove();
    }
});
