module SessionsHelper
  def show_messages
    css_classes = { alert: 'danger', notice: 'info' }

    result = nil

    css_classes.each do |key, css_class|
      flash_text = flash[key]
      next unless flash_text
      url = flash["#{key}_url".to_s]
      content = if url
                  link_to flash_text, url, target: '_blank'
                else
                  flash_text
                end

      message = content_tag :div, content, class: "alert alert-#{css_class}"
      if result
        result << message
      else
        result = message
      end

    end

    return result
  end

end
