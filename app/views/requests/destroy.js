$('.delete-request').bind('ajax:success', function() {
    $(this).closest('.request-in-list').fadeOut(function() {
        $(this).remove();
        if( $('.request-in-list').length===0  )  $('.requests').append("<h5 class='text-center'> Запитів не знайдено</h5>");
    });
});