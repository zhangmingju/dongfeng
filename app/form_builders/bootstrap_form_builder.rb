class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, to: :@template

  def error_messages
    return '' if object.errors.empty?
    messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: object.errors.count,
                      resource: object.class.model_name.human.downcase)
    html = <<-HTML
    <div class="alert alert-danger">
      <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
          ×</button>
      <span class="glyphicon glyphicon-hand-right"></span> <strong>#{sentence}</strong>
      <hr class="message-inner-separator">
      <p>无效　　　　　
          #{messages}</p>
    </div>
    HTML
    html.html_safe
  end

  %w( text_field text_area url_field file_field collection_select select email_field password_field ).each do |method_name|
    define_method(method_name) do |method, *tag_value|
      content_tag(:div, class: 'form-group') do
        label(method, class: 'col-sm-2 control-label') +
        if method_name == "text_area"
          content_tag(:div, class: 'col-sm-10') do
            super(method, *tag_value)
          end
        else
          content_tag(:div, class: 'col-sm-4') do
            super(method, *tag_value)
          end
        end
      end
    end
  end

  def submit(*tag_value)
    content_tag(:div, class: 'form-group') do
      content_tag(:div, class: 'col-sm-4 col-sm-offset-5') do
        super
      end
    end
  end

end