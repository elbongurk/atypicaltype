class @Streamer
  @load: ->
    for streamer in document.querySelectorAll(".streamer")
      new Streamer(streamer)
      
  constructor: (@root) ->
    @spinner = document.querySelector(".spinner")
    @spinner.querySelector("a").addEventListener("click", this.loadMorePhotos)
    this.fetchPhotos() if !@root.querySelector("li:last-child")
      
  loadMorePhotos: (event) =>
    event.preventDefault() if event
    @spinner.classList.remove("spinner-off")
    @spinner.classList.add("spinner-on")
    this.fetchPhotos(@root.querySelector("li:last-child").getAttribute("data-created-time"))

  fetchPhotos: (since) =>
    url = "/photos.json"
    if since
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
    

      

