$(".notifications").html("<%= escape_javascript(render 'notifications/notifications_list', notifications: @notifications) %>");
$("#new-notifications").html("<%= @new_notifications.to_s unless @new_notifications.zero? %>");
$("#new-info").html("<%= (@new_notifications + @new_decisions).to_s unless (@new_notifications + @new_decisions).zero? %>");
