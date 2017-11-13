var setupLoading = function() {
  $('[data-behavior="loader"]').each(function(i, el) {
    var width = $(el).outerWidth();
    var height = $(el).outerHeight();
    $(el).on('click', function(e) {
      $(e.target).css('width', width);
      $(e.target).css('height', height);
    });
  });
}
