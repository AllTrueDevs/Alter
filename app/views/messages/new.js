$('.messages').html("<%= escape_javascript(render 'messages', messages: @messages, companion: @companion) %>");
$('#message_body').html('');