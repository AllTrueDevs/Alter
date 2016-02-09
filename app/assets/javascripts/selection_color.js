$('select').on('change', function() {
    $(this).parent().attr('class', 'modal-body');
    $(this).parent().addClass('label-'+this.value)
})

