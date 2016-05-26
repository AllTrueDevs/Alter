setTimeout(function(){
    $("#post-"+"<%= @post.id %>").fadeOut(function() {
        $(this).remove();
        if($('.post-in-list').length===0)
            $('.posts').append("<h5 class='text-center'>На стіні немає записів</h5>");
        $posts_count = "<%= @posts.size %>";
        if (parseInt($posts_count) === 0)
            $('#wall-counter').text('Записів немає');
        else
            $('#wall-counter').text($posts_count + ' записів');
    });
}, 200);