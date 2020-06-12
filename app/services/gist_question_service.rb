class GistQuestionService
  def initialize(question)
    @question = question
  end

  def call(user)
    result = octokit_client.create_gist gist_params
    Gist.create({ question: @question, gist_id: result.id, url: result.html_url, user: user })
  end

  private

  def octokit_client
    @octokit_client ||= Octokit::Client.new
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
