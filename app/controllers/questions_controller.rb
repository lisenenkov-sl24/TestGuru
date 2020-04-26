class QuestionsController < ApplicationController
  before_action :find_test
  rescue_from ActiveRecord::RecordNotFound, with: :resque_with_question_not_found

  def index
    respond_to do |format|
      @questions = Question.select(:id, :body).where(test: @test)
      format.html do
        render inline: %(
        <%= tag.h2 "Вопросы #{@test}" %>
        <%= link_to 'Создать', new_test_question_path %>
        <br/>
        <% @questions.each do |question| %>
          <div><%= link_to question.body, test_question_path(id: question.id)%></div>
        <% end %>
        )
      end
      format.text { render plain: @questions.pluck(:body).join("\n") }
    end
  end

  def show
    respond_to do |format|
      @question = @test.questions.select(:id, :body).includes(:answers).find(params[:id].to_i)
      format.html do
        render inline: %(
        <p id="notice"><%= notice %></p> 
        <h2>Тест <%= @test%></h2>
        <div><label>Текст вопроса </label><%= @question.body%></div>
        <%= form_for([@test, @question], method: :delete) do |q| %>
          <%= submit_tag("Удалить") %>
        <% end %>

        <h3>Ответы</h3>
        <% @question.answers.select(:text, :correct).each do |answer| %>
          <div><% if(answer.correct) %>
          <b><%= answer.text%></b>
          <% else %>
          <%= answer.text%>
          <% end %>
          </div>
        <% end %>

        <%= link_to 'К списку', test_questions_path%>
        )
      end
      format.text { render plain: @question.body }
    end
  end

  def new
    @question = Question.new
    @question.answers.push(Answer.new(correct: true))
    3.times {@question.answers.push(Answer.new)}
  end

  def create
    @question = Question.new(params.require(:question).permit(:body, answers_attributes: [:text, :correct]))
    @question.test = @test
    if @question.save
      redirect_to test_question_path(id: @question.id), notice: 'Вопрос успешно создан'
    else
      render :new
    end
  end

  def destroy
    redirect_to :test_questions
    @test.questions.find(params[:id].to_i).destroy()
  end
  
  private

  def find_test
    @test = Test.select(:id, :title).find(params[:test_id].to_i)
  end

  def resque_with_question_not_found
    render plain: 'Вопрос не найден'
  end
end
