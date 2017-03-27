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

  def custome_time_ago(time)
    timeago_tag time, lang: 'zh-CN', limit: 1.years.ago
  end

  def user_role(user)
    user.roles.first.name || "普通用户"
  end
end
