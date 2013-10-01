class @Cart
  @load: ->
    for cart in document.querySelectorAll(".cart")
      new Cart(cart)

  constructor: (@root) ->
    quantity = @root.querySelector("#line_item_quantity")
    quantity.addEventListener("change", this.submitForm) if quantity

  submitForm: (event) =>
    form = @root.querySelector("form.edit_line_item")
    form.submit() if form
