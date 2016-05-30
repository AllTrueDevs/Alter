$(".users-list").fadeOut(400, function() {
    $('.users-list').html("<%= escape_javascript(render partial: 'users_list', locals: { users: @user }) %>").fadeIn(200);
});