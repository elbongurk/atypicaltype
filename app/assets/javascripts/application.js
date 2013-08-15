//= require jquery
//= require jquery_ujs


var changeScene = function(event) {
  var sceneNum = $(this).val();
  var scene = $(".scene");
  $(".scene").removeClass("scene-1 scene-2 scene-3").addClass("scene-" + sceneNum);
}


$(document).ready(function() {
  $(".scene-selector input[name='scene']").on("change", changeScene);  
});
