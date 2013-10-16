class @Form
  @load: ->
    for form in document.querySelectorAll("form")
      new Form(form)

  constructor: (@root) ->
    @root.addEventListener("submit", this.disableSubmitButton)
  
  disableSubmitButton: (event) =>
    submit = @root.querySelector("input[type=submit]")
    submit.setAttribute("disabled", "disabled") if submit
