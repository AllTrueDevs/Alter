$('.delete-notification').bind('ajax:success', function() {

    $(this).closest('.not').fadeOut(function() {
        $(this).remove();
        if( $('.not').length===0  )  $('.notifications').append("<h5 class='text-center'> Запитів не знайдено</h5>");
    });
});