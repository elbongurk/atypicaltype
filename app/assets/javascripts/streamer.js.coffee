class @Streamer
  @load: ->
    for streamer in document.querySelectorAll(".streamer")
      new Streamer(streamer)
      
  constructor: (@root) ->
    @last_photo = @root.querySelector("li:last-child")
    if @last_photo
      window.addEventListener("scroll", this.checkScroll)      
    else
      this.fetchPhotos()
      
  checkScroll: =>
    height_remaining = document.height - (document.body.scrollTop + window.innerHeight)
    footer_height = window.innerWidth > 704 ? 224 : 726
    if height_remaining < footer_height
      this.fetchPhotos(@last_photo.getAttribute("data-created-time"))
      window.removeEventListener("scroll", this.checkScroll)
          
  fetchPhotos: (since = 0) =>
    Utils.ajax("GET", "/photos.json?since=#{since}", this.addPhotos)
  
  addPhotos: (data) =>
    if data.photos.length == 0
      setTimeout(this.fetchPhotos, 1000)
    else      
      @root.insertAdjacentHTML('beforeend', JST["views/photos/index"](photos: data.photos))

    if data.photos.length == 12
      @last_photo = @root.querySelector("li:last-child")
      window.addEventListener("scroll", this.checkScroll)                  
      