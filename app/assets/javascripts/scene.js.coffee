class @Scene
  @load: ->
    for scene in document.querySelectorAll(".scene")
      new Scene(scene)
      
  constructor: (@root) ->
    for contrastOption in @root.querySelectorAll("input[name=contrast]")
      contrastOption.addEventListener("change", this.updateImage)

    for brightnessOption in @root.querySelectorAll("input[name=brightness]")
      brightnessOption.addEventListener("change", this.updateImage)

    for sceneSelector in @root.querySelectorAll("input[name=scene]")
      sceneSelector.addEventListener("change", this.changeScene)
    
  changeScene: (event) =>
    @root.classList.remove("scene-1")
    @root.classList.remove("scene-2")
    @root.classList.remove("scene-3")

    scene = @root.querySelector("input[name=scene]:checked").value
    
    @root.classList.add("scene-#{scene}")

  updateImage: (event) =>
    photoUrl = @root.getAttribute("data-photo-url")
    contrast = @root.querySelector("input[name=contrast]:checked").value
    brightness = @root.querySelector("input[name=brightness]:checked").value

    document.getElementById("line_item_brightness").value = brightness
    document.getElementById("line_item_contrast").value = contrast
    
    url = "url(#{photoUrl}&contrast=#{contrast}&brightness=#{brightness})"

    for panel in @root.querySelectorAll(".panel")
      panel.style.backgroundImage = url
    
