class TestsController < ApplicationController
  before_action :find_test, only: %i[show edit update destroy start]

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

  def show; end

  def new
    @test = Test.new
  end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to tests_path
    else
      render :new
    end
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to tests_path
    else
      render :new
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  def start
    redirect_to @test.start
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :category_id, :level, :author_id)
  end
end
