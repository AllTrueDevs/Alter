$('.delete-request').bind('ajax:success', function() {
    $(this).closest('.request-in-list').fadeOut();
});