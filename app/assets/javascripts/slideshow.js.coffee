class @SlideShow
  @load: ->
    for slideshow in document.querySelectorAll(".slideshow")
      new SlideShow(slideshow)

  constructor: (@root) ->
    setInterval(this.changeSlide, 3000);
    
  changeSlide: =>
    current = @root.querySelector(".slide-active")
    next = current.nextElementSibling || @root.firstElementChild
    next.classList.add("slide-active")
    current.classList.remove("slide-active")
      
