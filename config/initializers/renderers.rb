[:pdf, :png].each do |type|
  ActionController::Renderers.add type do |obj, options|
    bright = options[:bright] || 0
    contrast = options[:contrast] || 0

    response_body = obj.send("to_#{type}", { bright: bright, contrast: contrast })
  end  
end
