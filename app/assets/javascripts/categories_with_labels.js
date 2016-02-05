$(document).ready(function() {
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
            if (checked === true)
                $(".categories-labels").append("<span class='label label-1 category-label category-" + element.prop('value') + "'>Category</span>");
            else
                $(".category-" + element.prop('value')).remove();
        }
    });
    $('label input').first().click(function(){
        if ($('label input').first().prop('checked') === true){
            $(".categories .label").remove();
            for ( i=1; i<$('label input').length; i++)
                            $(".categories-labels").append("<span class='label label-1 category-label category-" + $('label input').eq(i).val() + "'>Category</span>");
        }
        else
            $(".categories .label").remove();
    });
});