Share = {
    vkontakte: function() {
        url  = 'http://vkontakte.ru/share.php?';
        url += 'url='          + encodeURIComponent(window.location.href);
        url += '&title='       + encodeURIComponent($('.title').text());
        url += '&description=' + encodeURIComponent($('.description').text().substring(0, $('.description').text().substring(0, 250).lastIndexOf(" "))+'...');
        url += '&image='       + encodeURIComponent($('.photo').attr('src'));
        url += '&noparse=true';
        Share.popup(url);
    },
    twitter: function() {
        url  = 'https://twitter.com/share?';
        url += 'url='      + encodeURIComponent(window.location.href);
        url += '&text='      + encodeURIComponent($('.title').text());
        url +='&via=alter_dev'
        Share.popup(url);
    },

    //facebook: function() {
    //    url  = 'https://www.facebook.com/sharer/sharer.php?';
    //    url += 'src=sp&u='       + window.location.href;
    //    url += '&t='     + encodeURIComponent($('.title').text());
    //    url += '&description='   + encodeURIComponent($('.description').text());
    //    url += '&picture=' + encodeURIComponent($('.photo').attr('src'));
    //    Share.popup(url);
    //},

    popup: function(url) {
        window.open(url,'','toolbar=0,status=0,width=626,height=436');
    }
};