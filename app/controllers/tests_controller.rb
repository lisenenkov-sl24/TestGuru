class TestsController < ApplicationController
  def index
    respond_to do |format|
      @tests = Test.select(:id, :title)
      format.html do
        render inline: %(
        <h2>Тесты</h2>
        <br/>
        <% @tests.each do |test| %>
          <div><%= link_to test.title, test%></div>
        <% end %>)
      end
      format.text { render plain: @tests.pluck(:title).join("\n") }
    end
  end

  def show
    @test = Test.find(params[:id].to_i)
    respond_to do |format|
      format.html do
        render inline: %(<h3><%= @test.title%></h3>
          <div><label>Уровень:</label> <%= @test.level%></div>
          <div><label>Категория:</label> <%= @test.category%></div>
          <div><label>Автор:</label> <%= @test.author%></div>
          <div><%= link_to 'Вопросы', test_questions_path(test_id: @test.id)%></div>)
      end
    end
  end

end
