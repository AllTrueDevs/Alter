$('#notification-<%= @notification.id %>').fadeOut(500);
setTimeout(function(){
    $(".notification-index").html("<%= escape_javascript(render partial: 'notifications/notifications_list', locals: { notifications: @notifications }) %>");
}, 800);
var counter = "<%= current_user.counters(:notifications) %>";
$('#new-notifications-count').text((counter != 0)? counter : '');