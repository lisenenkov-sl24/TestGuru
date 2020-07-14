module ActiverecordHelper
  def show_errors(object)
    return unless object && object.errors.present?

    div_options = { class: 'resource-errors' }
    begin
      div_options[:data] = { resource_id: object.id }
    rescue => _
    end

    content_tag :div, div_options do
      div_content = content_tag :p, t('activerecord.errors.detected', count: object.errors.count)
      div_content << content_tag(:ul) do
        result = ActiveSupport::SafeBuffer.new
        object.errors.full_messages.each do |message|
          result << content_tag(:li, message)
        end
        result
      end
    end
  end

  def question_edit_header(question)
    return t('activerecord.helpers.question.edit', test: question.test.title) if question.persisted?

    t('activerecord.helpers.question.new', test: question.test.title)
  end

  def test_edit_header(test)
    return t('activerecord.helpers.test.edit', test: test.title) if test.persisted?

    t('activerecord.helpers.test.new', test: test.title)
  end

  def time_limit(seconds)
    return t('activerecord.helpers.unlimited') if seconds == 0

    distance_of_time(seconds)
  end
end
