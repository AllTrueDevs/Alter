$(".request-actions").html("<%= escape_javascript(render 'requests/request_actions', request: @request) %>");
if ($('#unchecked-requests-count').length > 0){
    $('#unchecked-requests-count').text(parseInt($('#unchecked-requests-count').text()) - 1);
    if (parseInt($('#unchecked-requests-count').text()) === 0){
        $('#unchecked-requests-count').remove();
    }
}
//if ($('#new-info').length > 0){
//    $('#new-info').text(parseInt($('#new-info').text()) - 1);
//    if (parseInt($('#new-info').text()) === 0){
//        $('#new-info').remove();
//    }
//}