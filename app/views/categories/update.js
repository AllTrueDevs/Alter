$("#editModal_"+"<%= @category.id %>").modal('hide');
setTimeout(function(){
    $("#category_"+"<%= @category.id %>").html("<%= escape_javascript(render partial: 'category_color', locals: {category: @category}) %>");
}, 200);