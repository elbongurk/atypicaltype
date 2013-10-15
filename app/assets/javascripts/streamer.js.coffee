class @Streamer
  @MAX_PHOTOS: 12

  @load: ->
    for streamer in document.querySelectorAll(".streamer")
      new Streamer(streamer)
      
  constructor: (@root) ->
    @polling = !@root.querySelector("li:last-child")
    if @polling
      this.fetchPhotos()
    else
      window.addEventListener("scroll", this.checkScroll)      
      
  checkScroll: =>
    height_remaining = document.height - (document.body.scrollTop + window.innerHeight)
    footer_height = if window.innerWidth > 704 then 224 else 726
    if height_remaining < footer_height
      window.removeEventListener("scroll", this.checkScroll)      
      this.fetchPhotos(@root.querySelector("li:last-child").getAttribute("data-created-time"))
          
  fetchPhotos: (since) =>
    url = "/photos.json"
    if since
      url += "?since=#{since}"
    Utils.ajax("GET", url, this.addPhotos)
  
  addPhotos: (data) =>
    if data.photos.length > 0
      @root.insertAdjacentHTML('beforeend', JST["views/photos/index"](photos: data.photos))
      @polling = false

    if data.photos.length == MAX_PHOTOS
      window.addEventListener("scroll", this.checkScroll)

    if @polling
      setTimeout(this.fetchPhotos, 1000)

