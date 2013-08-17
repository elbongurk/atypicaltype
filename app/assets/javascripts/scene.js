(function(scene, $, undefined) {
  var root;

  var panels;
  var photoUrl;

  scene.init = function() {
    root = $(".scene");
    photoUrl = root.data("photoUrl");
    panels = root.find(".panel");
    
    return root;
  };

  scene.changeScene = function(sceneNum) {
    root.removeClass("scene-1 scene-2 scene-3").addClass("scene-" + sceneNum);
  };

  scene.adjustImage = function(contrast, brightness) {
    var url = photoUrl + "?contrast=" + contrast + "&bright=" + brightness
    panels.each(function() {
      $(this).css("background-image", "url(" + url + ")");
    });
  };
})(window.scene = window.scene || {}, window.jQuery);
