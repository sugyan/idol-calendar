$(function () {
    var hr = $('hr.now');
    if (hr.get(0)) {
        $('html, body').animate({ scrollTop: hr.siblings().eq(hr.index() - 1).offset().top - 40 }, 1500);
    }
    $('#permalink').click(function () {
        this.select();
    });
});
