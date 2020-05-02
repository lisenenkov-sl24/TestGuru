class TestsController < ApplicationController
  def index
    respond_to do |format|
      @tests = Test.select(:id, :title)
      format.html { }
      format.text { render plain: @tests.pluck(:title).join("\n") }
    end
  end

  def show
    @test = Test.find(params[:id].to_i)
  end

end
