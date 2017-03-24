module ApplicationHelper

  def bootstrap_form_for(object, options = {}, &block)
    options[:html] ||= {}
    options[:html][:class] = 'form-horizontal'
    options[:html][:role] = 'form'
    options[:html][:multipart] = 'true'
    options[:html]["data-parsley-validate"] = true
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end
end
