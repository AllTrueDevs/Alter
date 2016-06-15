$("#notification-"+"<%= @notification.id %>").fadeOut(function() {
    $(this).remove();
    var counter = "<%= current_user.counters(:notifications) %>";
    $('#new-notifications-count').text((counter != 0)? counter : '');
    if( $('.notification').length === 0  )  $('.notification-index').append("<p class='nothing-to-show'> Сповіщень не знайдено</h5>");
});