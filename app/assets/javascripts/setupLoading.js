var setupLoading = function() {
  $('[data-behavior="loader"]').each(function(i, el) {
    var width = $(el).outerWidth();
    if (width > 0) {
      $(el).on('click', function(e) {
        $(e.target).css('width', width);
      });
    }
  });
}
