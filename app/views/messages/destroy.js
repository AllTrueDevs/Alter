setTimeout(function(){
    $("#post-"+"<%= @post.id %>").fadeOut(function() {
        $(this).remove();
        if($('.post-in-list').length === 0)
            $('.posts').append("<p class='nothing-to-show'>На стіні немає записів</p>");
        $posts_count = "<%= @posts.size %>";
        $posts_count = (parseInt($posts_count) != 0)? '(' + $posts_count + ')' : '';
        $('#wall-counter').text($posts_count)
    });
}, 200);
