module ApplicationHelper
  def full_title page_title = ""
    base_title = t :base_title
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def link_to_function name, *args, &block
    html_options = args.extract_options!.symbolize_keys

    function = block_given? ? update_page(&block) : args[0] || ""
    onclick = "#{"#{html_options[:onclick]};
      "if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"

    content_tag(:a, name, html_options.merge(href: href,
      onclick: onclick))
  end

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields name, f, association
    render_fields f, association
    link_to_function(name, "add_fields(this, \"#{association}\",
      \"#{escape_javascript(@tmpl)}\")")
  end

  def add_fields_answer f, association
    render_fields f, association
    @tmpl = @tmpl.gsub /(?<!\n)\n(?!\n)/, " "
    return "<script> var #{association.to_s}_field = '#{@tmpl.to_s}' </script>"
      .html_safe
  end

  def render_header
    if admin_signed_in?
      render "layouts/header_admin"
    elsif user_signed_in?
      render "layouts/header_user"
    else
      render "layouts/header"
    end
  end

  def class_for_label status
    case status
    when Settings.exam.start
      Settings.labels.primary
    when Settings.exam.testing
      Settings.labels.warning
    when Settings.exam.unchecked
      Settings.labels.info
    when Settings.exam.checked
      Settings.labels.success
    end
  end

  def result_label result
    result.is_correct? ? Settings.labels.success : Settings.labels.danger
  end

  private
  def render_fields f, association
    new_object = f.object.model.class.reflect_on_association(association).klass.new
    @tmpl = f.fields_for(association, new_object,
      child_index: "new_#{association}") do |b|
      render "#{association.to_s.singularize}_field", f: b
    end
  end
end
