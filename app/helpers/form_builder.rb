class FormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::DateHelper

  def errors
    with_error_text(:base, "")
  end
  
  def initialize(object_name, object, template, options = {}, &proc)
    super(object_name, object, template, options, &proc)    
    @method = @options[:method]
  end

  def fieldset_for(method, options = {}, &block)
    builder = self.class.new(@object_name, @object, @template, @options.merge(method: method))
    content = @template.capture(builder, &block)
    @template.content_tag(:fieldset, with_error_text(method, content), options)
  end

  def label(method = @method, label = nil, options = {})
    super(method, label, with_options(method, options))
  end

  def text_field(method = @method, options = {})
    super(method, with_options(method, options))
  end

  def text_field(method = @method, options = {})    
    super(method, with_options(method, options))
  end

  def check_box(method = @method, options = {})
    super(method, with_options(method, options))
  end

  def email_field(method = @method, options = {})
    super(method, with_options(method, options))
  end

  def text_area(method = @method, options = {})
    super(method, with_options(method, options))
  end
    
  def select_field(choices, options = {}, html_options = {})
    select(@method, choices, options = {}, html_options = {})
  end
  
  def select(method, choices, options = {}, html_options = {})
    super(method, choices, options, with_options(method, options))
  end
  
  protected

  def has_errors(method)
    @object.errors[method].present?
  end

  def determine_value(method)
    @object.send(method)
  end

  def determine_error(method)
    if method == :base
      @object.errors[:base].first
    else
      "#{method.to_s.humanize} #{@object.errors[method].first}"
    end
  end

  private

  def with_error_text(method, content)
    key = @method || method
    if has_errors(key)
      content << @template.content_tag(:p, determine_error(key), class: "form-error")
    else
      content
    end
  end

  def with_options(method, options)
    key = @method || method
    if has_errors(key)
      options.merge(class: "error", value: determine_value(key))
    else
      options.merge(value: determine_value(key))
    end
  end
end
