class BraintreeFormBuilder < FormBuilder

  def initialize(object_name, object, template, options = {}, &proc)
    super(object_name, object, template, options, &proc)    
    @braintree_params = @options[:params]
    @braintree_errors = @options[:errors]
  end

  def fields_for(record_name, record_object = nil, options = {}, &block)
    options.merge!(builder: BraintreeFormBuilder, 
                   params: @braintree_params && @braintree_params[record_name],
                   errors: @braintree_errors && @braintree_errors.for(record_name))
    super(record_name, record_object, options, &block)
  end

  def tr_data(url, options = {})    
    data = { redirect_url: url, transaction: { type: "sale" }.merge(options) }
    hidden_field_tag(:tr_data, Braintree::TransparentRedirect.transaction_data(data))
  end

  protected
  
  def has_errors(method)
    @braintree_errors && @braintree_errors.on(method).any?
  end

  def determine_value(method)
    @braintree_params && @braintree_params[method]
  end

  def determine_error(method)
    @braintree_errors.on(method).first.message
  end
end
