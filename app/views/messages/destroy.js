setTimeout(function(){
    $("#post-"+"<%= @post.id %>").fadeOut(function() {
        $(this).remove();
        if($('.post-in-list').length === 0)
            $('.posts').append("<h5 class='text-center'>На стіні немає записів</h5>");
        $posts_count = "<%= @posts.size %>";
        $posts_count = (parseInt($posts_count) != 0)? '(' + $posts_count + ')' : '';
        $('#wall-counter').text($posts_count)
    });
}, 200);
