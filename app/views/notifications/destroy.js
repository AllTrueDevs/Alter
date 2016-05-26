$("#notification-"+"<%= @notification.id %>").fadeOut(function() {
    $(this).remove();
    if( $('.notification').length === 0  )  $('.notification-index').append("<h5 class='text-center'> Сповіщень не знайдено</h5>");
});