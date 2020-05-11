class ResultsController < ApplicationController
  before_action :find_result, only: %i[show update result]

  def show
    redirect_to completed_result_path(@result) if @result.completed?

    @question_count = @result.test.questions.count
  end

  def result; end

  def update
    @result.accept!(answer_ids)
    if @result.completed?
      redirect_to completed_result_path(@result)
    else
      redirect_to @result
    end
  end

  private

  def find_result
    @result = Result.find(params[:id])
  end

  def answer_ids
    (params[:answers] || []).map(&:to_i)
  end
end
