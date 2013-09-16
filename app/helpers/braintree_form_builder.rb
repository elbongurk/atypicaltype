class BraintreeFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::DateHelper

  def initialize(object_name, object, template, options = {}, &proc)
    super(object_name, object, template, options, &proc)    
    @method = @options[:method]
    @braintree_params = @options[:params]
    @braintree_errors = @options[:errors]
  end

  def fields_for(record_name, record_object = nil, options = {}, &block)
    options.merge!(builder: BraintreeFormBuilder, 
                   params: @braintree_params && @braintree_params[record_name],
                   errors: @braintree_errors && @braintree_errors.for(record_name))
    super(record_name, record_object, options, &block)
  end

  def fieldset_for(method, options = {}, &block)
    builder = BraintreeFormBuilder.new(@object_name, @object, @template, @options.merge(method: method))
    content = @template.capture(builder, &block)
    @template.content_tag(:fieldset, with_error_text(method, content), options)
  end

  def label(method = @method, options = {})
    super(method, with_options(method, options))
  end

  def text_field(method = @method, options = {})    
    super(method, with_options(method, options))
  end

  def email_field(method = @method, options = {})
    super(method, with_options(method, options))
  end
  
  def select(method, choices, options = {}, html_options = {})
   super(method, choices, options, with_options(method, options))
  end

  def tr_data(url, options = {})    
    data = { redirect_url: url, transaction: { type: "sale" }.merge(options) }
    hidden_field_tag(:tr_data, Braintree::TransparentRedirect.transaction_data(data))
  end

  private
  
  def has_errors(method)
    @braintree_errors && @braintree_errors.on(method).any?
  end

  def determine_value(method)
    @braintree_params && @braintree_params[method]
  end

  def determine_error(method)
    @braintree_errors.on(method).first.message
  end

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
