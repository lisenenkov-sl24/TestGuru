module ActiverecordHelper
  def show_errors(object)
    return unless object && object.errors.present?

    content_tag :div, class: 'resource-errors', data: { resource_id: object.id } do
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
end
