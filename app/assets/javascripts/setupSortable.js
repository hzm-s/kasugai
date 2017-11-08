var setupSortable = function() {
  var list = document.querySelector('.js-sortable-list');
  if ($(list).length <= 0) {
    return;
  }

  Sortable.create(list, {
    handle: '.js-sortable-handle',
    ghostClass: 'sw-Sortable-ghost',
    scroll: true,
    onEnd: function(e) {
      $.ajax({
        type: 'PATCH',
        url: e.item.getAttribute('data-sort-url'),
        dataType: 'json',
        data: { new_position: e.newIndex },
      });
    }
  });
}
