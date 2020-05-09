module QuestionHelper
  def question_edit_header(question)
    return "Edit #{question.test} Question" if question.persisted?

    "Create New #{question.test} Question"
  end
end
