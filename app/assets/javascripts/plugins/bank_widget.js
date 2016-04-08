if (typeof(iFinance) == "undefined") {
    if (typeof(iFinanceData) == "undefined") {
        document.write('<scr' + 'ipt src="http://i.i.ua/js/i/finance_informer.js?1" type="text/javascript" charset = "windows-1251"></scr' + 'ipt>');
        iFinanceData = [];
    }
    iFinanceData.push({b: 10, c: [840, 978, 643], enc: 0, lang: 1, p: '14'});
}
else {
    window['oiFinance14'] = new iFinance();
    window['oiFinance14'].gogo({b: 10, c: [840, 978, 643], enc: 0, lang: 1, p: '14'});
}
