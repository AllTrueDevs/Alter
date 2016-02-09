$('.delete-notification').bind('ajax:success', function() {
    $(this).closest('.not').fadeOut(function() {
        $(this).remove();
        $("#new-notifications").html("<%= @new_notifications.to_s unless @new_notifications.zero? %>");
        $("#new-info").html("<%= (@new_notifications + @new_decisions).to_s unless (@new_notifications + @new_decisions).zero? %>");
        if($('.not').length===0) $('.notifications').append("<h5 class='text-center'> Сповіщень не знайдено</h5>");
    });
});
