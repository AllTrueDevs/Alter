$(".notifications").html("<%= escape_javascript(render 'notifications/notifications_list', notifications: @notifications) %>");
if ($('#new-notifications-count').length > 0) {
    $('#new-notifications-count').text(parseInt($('#new-notifications-count').text()) - 1);
    if (parseInt($('#new-notifications-count').text()) === 0) {
        $('#new-notifications-count').remove();
    }
}