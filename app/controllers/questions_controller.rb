class QuestionsController < ApplicationController
  before_action :find_test
  before_action :find_question, only: [:show, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :resque_with_question_not_found

  def index
    @questions = @test.questions.select(:id, :body)
    respond_to do |format|
      format.html {}
      format.text { render plain: @questions.pluck(:body).join("\n") }
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.text { render plain: @question.body }
    end
  end

  def new
    @question = Question.new
    @question.answers.push(Answer.new(correct: true))
    3.times {@question.answers.push(Answer.new)}
  end

  def create
    @question = Question.new(question_params)
    @question.test = @test
    if @question.save
      redirect_to test_question_path(@test, @question), notice: 'Вопрос успешно создан'
    else
      render :new
    end
  end

  def destroy
    @question.destroy()
    redirect_to :test_questions
  end
  
  private

  def find_test
    @test = Test.select(:id, :title).find(params[:test_id])
  end

  def find_question
    @question = @test.questions.select(:id, :body).includes(:answers).find(params[:id])
  end

  def resque_with_question_not_found
    render plain: 'Вопрос не найден'
  end

  def question_params
    params.require(:question).permit(:body, answers_attributes: [:text, :correct])
  end
end
