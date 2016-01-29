$(".notifications").html("<%= escape_javascript(render 'notifications/notifications_list', notifications: @notifications) %>");
