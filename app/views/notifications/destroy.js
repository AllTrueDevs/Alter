$('.delete-notification').bind('ajax:success', function () {
    debugger;
    if (hasClass($(this).parent().parent().parent().parent().parent(), 'notification-new')) {
        if ($('#new-notifications-count').length > 0) {
            $('#new-notifications-count').text(parseInt($('#new-notifications-count').text()) - 1);
            if (parseInt($('#new-notifications-count').text()) === 0) {
                $('#new-notifications-count').remove();
            }
        }
    }
    $(this).closest('.notification-in-list').fadeOut(function () {
        $(this).remove();
        if ($('.notification-in-list').length === 0) $('.notifications').append("<h5 class='text-center'> Сповіщень не знайдено</h5>");
    });
});

function hasClass(element, cls) {
    return (' ' + element.prop('class') + ' ').indexOf(' ' + cls + ' ') > -1;
}
