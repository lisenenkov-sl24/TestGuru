class GistQuestionService
  def initialize(question)
    @question = question
  end

  def call(user)
    result = github.gists.create gist_params
    url = result.html_url
    Gist.create({ question: @question, url: url, user: user })
  end

  private

  def github
    @github ||= Github.new
  end

  def gist_params
    {
      description: I18n.t('gists.description', test: @question.test.title),
      public: true,
      files: {
        'question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    "#{@question.body}\n"\
    "#{@question.answers.pluck(:text).join("\n")}"
  end
end
