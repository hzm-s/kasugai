(function() {
  this.Helpers || (this.Helpers = {});
})(this);

Helpers.appendNode = function($parent, $child) {
  $child.appendTo($parent).hide().fadeIn(500);
};
