class @Utils
  @ajax: (method, path, success, error) ->
    request = new XMLHttpRequest()
    request.addEventListener "readystatechange", ->
      if request.readyState == 4
        if request.status in [200, 304]
          success(JSON.parse(request.responseText))
        else
          error(request.status, request.responseText)
    request.open(method, path, true)
    request.send()
