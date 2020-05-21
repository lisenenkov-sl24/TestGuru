module SessionsHelper
  def show_messages
    return if flash.empty?

    content_tag :div do
      flash.each do |type, text|
        concat content_tag :p, text, class: ['flash', type] if text
      end
    end
  end
end
