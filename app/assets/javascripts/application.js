//= require jquery
//= require jquery_ujs

//= require_self
//= require_tree .

(function($, undefined) {
  $(document).ready(function() {
    var sceneElement = scene.init();
    toolbar.init(sceneElement);
  });
})(window.jQuery);
