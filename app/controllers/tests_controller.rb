class TestsController < ApplicationController
  before_action :find_test, only: %i[start]

  def index
    respond_to do |format|
      @tests =
        Test
        .select(
          'tests.*',
          '(select count(*) from questions where questions.test_id = tests.id) as question_count'
        )
        .includes(:category, :author)

      format.html
      format.text { render plain: @tests.pluck(:title).join("\n") }
    end
  end

  def start
    redirect_to @test.start(current_user)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end
end
