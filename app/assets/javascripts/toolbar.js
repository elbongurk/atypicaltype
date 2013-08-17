(function(toolbar, $, undefined) {
  var root;
  
  var contrast;
  var brightness;

  var values = ["0", "25", "50", "75"];
  
  toolbar.init = function(sceneElement) {
    root = sceneElement.find(".toolbar");
    contrast = root.find("button[name='contrast']");
    brightness = root.find("button[name='bright']");

    contrast.on("click", changeContrast);
    brightness.on("click", changeBrightness);

    root.on("change", "input[name='scene']", function(event) {
      scene.changeScene($(this).val());
    });

    return root;
  };

  var changeContrast = function(event) {
    var contrastIndex = (values.indexOf(contrast.val()) + 1) % values.length;
    var contrastAmount = values[contrastIndex];

    contrast.val(contrastAmount);

    scene.adjustImage(contrastAmount, brightness.val());
  };

  var changeBrightness = function(event) { 
    var brightnessIndex = (values.indexOf(brightness.val()) + 1) % values.length;
    var brightnessAmount = values[brightnessIndex];

    brightness.val(brightnessAmount);

    scene.adjustImage(contrast.val(), brightnessAmount);
  };

})(window.toolbar = window.toolbar || {}, window.jQuery);
