$posts_count = "<%= @post.request.posts.size %>";
$('#wall-counter').text($posts_count + ' записів');
$("<%= escape_javascript(render partial: 'messages/post', locals: { post: @post }) %>").prependTo('.posts');
$('.posts h5').remove();
$('.message-form .fields').each(function() {
    return $(this).remove();
});
$('.message-form .add_nested_fields').prop('disabled', false);
