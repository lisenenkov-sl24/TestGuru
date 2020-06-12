class ResultsController < ApplicationController
  before_action :find_test, only: :index
  before_action :find_result, only: %i[show update result gist]

  def index; end

  def show
    redirect_to completed_result_path(@result) if @result.completed?

    @question_count = @result.test.questions.count
  end

  def result; end

  def gist
    begin
      gist_service = GistQuestionService.new(@result.current_question)
      gist = gist_service.call(current_user)
      flash[:notice_html] = t('.gist_created', url: gist.url)
    rescue Octokit::ClientError
      flash.alert = t('.gist_failed')
    end
    redirect_to @result
  end

  def update
    @result.accept!(answer_ids)
    if @result.completed?
      redirect_to completed_result_path(@result)
    else
      redirect_to @result
    end
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_result
    @result = Result.find(params[:id])
  end

  def answer_ids
    (params[:answers] || []).map(&:to_i)
  end
end
