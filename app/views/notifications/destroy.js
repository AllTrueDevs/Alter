$('.delete-notification').bind('ajax:success', function() {
    $(this).closest('.not').fadeOut(function() {
        $(this).remove();
        $("#new-notifications").html("<%= @new_notifications_count.to_s unless @new_notifications_count.zero? %>");
        //if ($('#new-info').length > 0){
        //    $('#new-info').text(parseInt($('#new-info').text()) - 1);
        //    if (parseInt($('#new-info').text()) === 0){
        //        $('#new-info').remove();
        //    }
        //}
        if($('.not').length===0) $('.notifications').append("<h5 class='text-center'> Сповіщень не знайдено</h5>");
    });
});
