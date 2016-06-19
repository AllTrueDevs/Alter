$posts_count = "<%= @post.request.posts.size %>";
$('#wall-counter').text('(' + $posts_count + ')');
$("<%= escape_javascript(render partial: 'messages/post', locals: { post: @post }) %>").prependTo('.post-index');
$('.posts h5').remove();
$('.message-form .fields').each(function() {
    return $(this).remove();
});
$('.message-form .add_nested_fields').prop('disabled', false);
