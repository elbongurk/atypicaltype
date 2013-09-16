class @Scene
  @load: ->
    for scene in document.querySelectorAll(".scene")
      new Scene(scene)
      
  constructor: (@root) ->
    @contrast = document.getElementById("line_item_contrast")
    @contrast.addEventListener("change", this.updateImage)

    @brightness = document.getElementById("line_item_brightness")
    @brightness.addEventListener("change", this.updateImage)

    for sceneSelector in @root.querySelectorAll("input[name=scene]")
      sceneSelector.addEventListener("change", this.changeScene)
    
  changeScene: (event) =>
    @root.classList.remove("scene-1")
    @root.classList.remove("scene-2")
    @root.classList.remove("scene-3")
    @root.classList.add("scene-#{event.target.value}")

  updateImage: (event) =>
    photoUrl = @root.getAttribute("data-photo-url")
    url = "url(#{photoUrl}?contrast=#{@contrast.value}&bright=#{@brightness.value})"
    for panel in @root.querySelectorAll(".panel")
      panel.style.backgroundImage = url
    
