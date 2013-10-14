class @Utils
  @ajax: (method, path, success, error) ->
    request = new XMLHttpRequest()
    request.addEventListener "readystatechange", ->
      if request.readyState == 4
        if request.status == 200
          success(JSON.parse(request.responseText))
        else
          error()
    request.open(method, path, false)
    request.send()
