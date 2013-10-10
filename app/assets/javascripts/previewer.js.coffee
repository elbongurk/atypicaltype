class @Previewer
  @load: ->
    for previewer in document.querySelectorAll(".previewer")
      new Previewer(previewer)
      
  constructor: (@root) ->
    for actionImageThumb in @root.querySelectorAll(".actionImageThumb")
      actionImageThumb.addEventListener("click", this.changeActionImage)
    
  changeActionImage: (event) =>
    current = @root.querySelector(".actionImageThumb-selected")
    next = event.target

    current.classList.remove("actionImageThumb-selected")
    next.classList.add("actionImageThumb-selected")
    
    currentIndex = current.getAttribute('data-index')
    nextIndex = next.getAttribute('data-index')

    actionImageFull = @root.querySelector(".actionImageFull")
    
    currentSlug = "-f#{currentIndex}"
    nextSlug = "-f#{nextIndex}"
    
    actionImageFull.src = actionImageFull.src.replace(currentSlug, nextSlug)
    
    productImage = @root.querySelector(".productImage")
    
    productImage.className = productImage.className.replace("-#{currentIndex}", "-#{nextIndex}")    
    