$(".request-actions").html("<%= escape_javascript(render 'requests/request_actions', request: @request) %>");
var counter = "<%= current_user.counters(:unchecked) %>";
$('#unchecked-requests-count').text((counter != 0)? counter : '');
