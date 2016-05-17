$(".notifications").html("<%= escape_javascript(render 'notifications/notifications_list', notifications: @notifications) %>");
$("#new-notifications").html("<%= @new_notifications_count.to_s unless @new_notifications_count.zero? %>");
//if ($('#new-info').length > 0){
//    $('#new-info').text(parseInt($('#new-info').text()) - 1);
//    if (parseInt($('#new-info').text()) === 0){
//        $('#new-info').remove();
//    }
//}