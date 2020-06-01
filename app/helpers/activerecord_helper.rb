module ActiverecordHelper
  def show_errors(object)
    return unless object.errors.present?

    concat content_tag(:p, t('activerecord.errors.detected', count: object.errors.count))

    list = object.errors.full_messages.map do |message|
      content_tag :li, message
    end
    concat content_tag :ul, combine_tags(list)
  end

  def question_edit_header(question)
    return t('activerecord.helpers.question.edit', test: question.test.title) if question.persisted?

    t('activerecord.helpers.question.new', test: question.test.title)
  end

  def test_edit_header(test)
    return t('activerecord.helpers.test.edit', test: test.title) if test.persisted?

    t('activerecord.helpers.test.new', test: test.title)
  end

  private

  def combine_tags(tags)
    combined_tags = nil
    tags.each do |tag|
      if combined_tags
        combined_tags << tag
      else
        combined_tags = tag
      end
    end

    combined_tags
  end
end
