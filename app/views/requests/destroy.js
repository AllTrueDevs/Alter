$("#deleteModal_"+"<%= @request.id %>").modal('hide');
setTimeout(function(){
    $("#request-"+"<%= @request.id %>").fadeOut(function() {
        $(this).remove();
        if( $('.request-in-list').length===0  )  $('.requests').append("<h5 class='text-center'> Запитів не знайдено</h5>");
    });
}, 200);
