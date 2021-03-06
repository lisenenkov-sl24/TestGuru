class Admin::TestsController < Admin::BaseController
  before_action :set_tests, only: %i[index update_inline]
  before_action :find_test, only: %i[show edit update destroy update_inline]

  def index
    respond_to do |format|
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
      redirect_to admin_tests_path
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def create
    @test = current_user.created_tests.new(test_params)
    if @test.save
      redirect_to admin_tests_path
    else
      render :new
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def set_tests
    @tests =
      Test
      .select(
        'tests.*',
        '(select count(*) from questions where questions.test_id = tests.id) as question_count'
      )
      .includes(:category, :author)
  end

  def test_params
    params.require(:test).permit(:title, :category_id, :level, :time_limit)
  end
end
