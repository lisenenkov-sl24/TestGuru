class Admin::QuestionsController < Admin::BaseController
  before_action :find_test, only: %i[new create]
  before_action :find_question, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :resque_with_question_not_found

  def show; end

  def new
    @question = Question.new(test: @test)
    @question.answers.push(Answer.new(correct: true))
    3.times { @question.answers.push(Answer.new) }
  end

  def edit
    @question.answers.push(Answer.new) if @question.answers.size < 4
  end

  def update
    if @question.update(question_params)
      redirect_to [:admin, @question.test]
    else
      render :edit
    end
  end

  def create
    @question = Question.new(question_params)
    @question.test = @test
    if @question.save
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to [:admin, @question.test]
  end

  private

  def find_test
    @test = Test.select(:id, :title).find(params[:test_id])
  end

  def find_question
    @question = Question.select(:id, :test_id, :body).find(params[:id])
  end

  def resque_with_question_not_found
    render plain: 'Вопрос не найден'
  end

  def question_params
    params.require(:question).permit(:body, answers_attributes: [:id, :text, :correct])
  end
end
