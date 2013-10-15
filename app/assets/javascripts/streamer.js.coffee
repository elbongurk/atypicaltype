class @Streamer
  @load: ->
    for streamer in document.querySelectorAll(".streamer")
      new Streamer(streamer)
      
  constructor: (@root) ->
    @spinner = document.querySelector(".spinner")
    @spinner.querySelector("a").addEventListener("click", this.loadMorePhotos)
    this.fetchPhotos() if !@root.querySelector("li:last-child")
      
  loadMorePhotos: (event) =>
    event.preventDefault()
    @spinner.classList.remove("spinner-off")
    @spinner.classList.add("spinner-on")
    setTimeout(this.fetchPhotos, 1000)

  fetchPhotos: =>
    url = "/photos.json"
    last_photo = @root.querySelector("li:last-child")
    if last_photo
      since = last_photo.getAttribute("data-created-time")
      url += "?since=#{since}"
    Utils.ajax("GET", url, this.addPhotos)
  
  addPhotos: (data) =>    
    if data.photos.length > 0
      @root.insertAdjacentHTML('beforeend', JST["views/photos/index"](photos: data.photos))

    if !@root.querySelector("li:last-child")
      setTimeout(this.fetchPhotos, 500)
    else
      @spinner.classList.remove("spinner-on")
      @spinner.classList.add("spinner-off")
    

      

