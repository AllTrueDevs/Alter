$(document).ready(function() {
  var my_data = $('#categories').data('cater');
  function search(id, myArray){
    for (var i=0; i < myArray.length; i++) {
      if (myArray[i].id === id) {
        return myArray[i];
      }
    }
  }
  $('#categories').multiselect({
      enableFiltering: true,
      filterPlaceholder: 'Пошук',
      includeSelectAllOption: true,
      selectAllText: 'Обрати всі',
      maxHeight: 200,
      buttonText: function(options, select) {
          return 'Оберіть категорії';
      },
      buttonTitle: function(options, select) {
          var labels = [];
          options.each(function () {
              labels.push($(this).text());
          });
          return labels.join(' - ');
      },
      onChange: function(element, checked) {
          if (checked === true){
            var result = search(parseInt(element.prop('value')), my_data);
            $(".categories-labels").append("<span class='label category-label category-" + result.id + "' style='background: #"+result.color +";'>" + result.name + "</span>");
          }

          else
              $(".category-" + element.prop('value')).remove();
      }
  });
  $('label input').first().click(function(){
      if ($('label input').first().prop('checked') === true){
          $(".categories .label").remove();
          for ( i = 1; i < $('label input').length; i++){
            var result = search(parseInt($('label input').eq(i).val()), my_data);
            $(".categories-labels").append("<span class='label category-label category-" + result.id + "' style='background: #"+result.color +";'>" + result.name + "</span>");
          }
      }
      else
          $(".categories .label").remove();
  });
});
