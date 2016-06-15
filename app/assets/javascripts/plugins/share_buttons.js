Share = {
    vkontakte: function() {
        url  = 'http://vkontakte.ru/share.php?';
        url += 'url='          + encodeURIComponent(window.location.href);
        url += '&title='       + encodeURIComponent($('.request-show .title').text());
        url += '&description=' + encodeURIComponent($('.request-show .description').text().substring(0, $('.request-show .description').text().substring(0, 250).lastIndexOf(" "))+'...');
        url += '&image='       + encodeURIComponent($('.request-show .photo').attr('src'));
        url += '&noparse=true';
        Share.popup(url);
    },
    twitter: function() {
        url  = 'https://twitter.com/share?';
        url += 'url='      + encodeURIComponent(window.location.href);
        url += '&text='      + encodeURIComponent($('.request-show .title').text());
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