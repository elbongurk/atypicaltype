[:pdf, :png].each do |type|
  ActionController::Renderers.add type do |obj, options|
    response_body = obj.send("to_#{type}")
  end  
end
