class @Previewer
  @load: ->
    for previewer in document.querySelectorAll(".previewer")
      new Previewer(previewer)
      
  constructor: (@root) ->
    for shotThumb in @root.querySelectorAll(".shotThumb")
      shotThumb.addEventListener("click", this.changeShot)
    for productSize in document.querySelectorAll(".product-size")
      productSize.addEventListener("click", this.changeSize)
      
  changeSize: (event) =>
    current = document.querySelector(".product-size-selected")
    next = event.currentTarget
    
    current.classList.remove("product-size-selected")
    next.classList.add("product-size-selected")
    
    currentSize = current.getAttribute("data-size")
    nextSize = next.getAttribute("data-size")
    
    for shotThumb in @root.querySelectorAll(".shotThumb")
      shotThumb.src = shotThumb.src.replace(currentSize, nextSize)
      shotThumb.setAttribute("data-product", shotThumb.getAttribute("data-product").replace(currentSize, nextSize))
      shotThumb.setAttribute("data-shot", shotThumb.getAttribute("data-shot").replace(currentSize, nextSize))
    
    productImage = @root.querySelector(".productImage")
    productImage.src = productImage.src.replace(currentSize.toUpperCase(), nextSize.toUpperCase())
    productImage.className = productImage.className.replace(currentSize, nextSize)
    
    shotFull = @root.querySelector(".shotFull")
    shotFull.src = shotFull.src.replace(currentSize, nextSize)
    
    sku = document.getElementById("line_item_variant_sku")
    sku.value = sku.value.replace(currentSize.toUpperCase(), nextSize.toUpperCase())
    
    currentPrice = current.getAttribute("data-price")
    nextPrice = next.getAttribute("data-price")
    
    for submit in document.querySelectorAll("input[type=submit]")
      submit.value = submit.value.replace(currentPrice, nextPrice)
    
  changeShot: (event) =>
    current = @root.querySelector(".shotThumb-selected")
    next = event.currentTarget

    current.classList.remove("shotThumb-selected")
    next.classList.add("shotThumb-selected")

    shotFull = @root.querySelector(".shotFull")
    shotFull.src = next.getAttribute('data-shot')
    
    productImage = @root.querySelector(".productImage")
    
    currentProduct = current.getAttribute('data-product')
    nextProduct = next.getAttribute('data-product') 

    productImage.className = productImage.className.replace(currentProduct, nextProduct)    
    