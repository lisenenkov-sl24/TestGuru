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
    gist_service = GistQuestionService.new(@result.current_question)
    gist_url = gist_service.call(current_user)
    redirect_to @result, flash: { notice: t('.gist_created'), notice_url: gist_url }
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
