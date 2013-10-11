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

    currentProduct = current.getAttribute('data-product')
    nextProduct = next.getAttribute('data-product')    

    actionImageFull = @root.querySelector(".actionImageFull")
    actionImageFull.src = next.getAttribute('data-action')
    
    productImage = @root.querySelector(".productImage")
    
    productImage.className = productImage.className.replace(currentProduct, nextProduct)    
    