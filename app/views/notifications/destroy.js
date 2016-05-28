$("#notification-"+"<%= @notification.id %>").fadeOut(function() {
    $(this).remove();
    if("<%= @notification.status %>" === "new"){
        if ($('#new-notifications-count').length > 0) {
            $('#new-notifications-count').text(parseInt($('#new-notifications-count').text()) - 1);
            if (parseInt($('#new-notifications-count').text()) === 0) {
                $('#new-notifications-count').remove();
            }
        }
    }
    if( $('.notification').length === 0  )  $('.notification-index').append("<h5 class='text-center'> Сповіщень не знайдено</h5>");
});