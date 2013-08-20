class @Scene
  @VALUES: ["0", "25", "50", "75"]

  @load: ->
    for scene in document.querySelectorAll(".scene")
      new Scene(scene)
      
  constructor: (@root) ->
    @contrast = @root.querySelector("button[name=contrast]")
    @contrast.addEventListener("click", this.changeContrast)

    @brightness = @root.querySelector("button[name=bright]")
    @brightness.addEventListener("click", this.changeBrightness)

    for sceneSelector in @root.querySelectorAll("input[name=scene]")
      sceneSelector.addEventListener("click", this.changeScene)
    
  changeScene: (event) =>
    @root.classList.remove("scene-1")
    @root.classList.remove("scene-2")
    @root.classList.remove("scene-3")
    @root.classList.add("scene-#{event.target.value}")

  changeContrast: (event) =>
    contrastIndex = (Scene.VALUES.indexOf(@contrast.value) + 1) % Scene.VALUES.length
    @contrast.value = Scene.VALUES[contrastIndex] 
    this.updateImage()

  changeBrightness: (event) =>
    brightnessIndex = (Scene.VALUES.indexOf(@brightness.value) + 1) % Scene.VALUES.length
    @brightness.value = Scene.VALUES[brightnessIndex]
    this.updateImage()

  updateImage: ->
    photoUrl = @root.getAttribute("data-photo-url")
    url = "url(#{photoUrl}?contrast=#{@contrast.value}&bright=#{@brightness.value})"
    for panel in @root.querySelectorAll(".panel")
      panel.style.backgroundImage = url
    
