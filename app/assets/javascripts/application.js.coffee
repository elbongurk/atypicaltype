//= require_tree "./views"

//= require "utils"
//= require "streamer"
//= require "previewer"
//= require "cart"
//= require "slideshow"

document.addEventListener "DOMContentLoaded", ->
  Streamer.load()
  Previewer.load()
  Cart.load()
  SlideShow.load()
