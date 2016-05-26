$(".votes-"+"<%= @request.id %>").html("<%= escape_javascript( render partial: 'layouts/votes', locals: { source: @request }) %>");

