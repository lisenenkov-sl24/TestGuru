class Admin::BadgesController < Admin::BaseController
  before_action :find_badge, only: %i[edit update destroy]
  rescue_from ArgumentError, with: :resque_with_argument_error

  def index; end

  def new
    @badge = badge_type!(params[:type]).new
  end

  def create
    @badge = Badge.new(badge_params)
    if @badge.save
      redirect_to admin_badges_path, notice: t('.badge_created')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badges_path, notice: t('.badge_updated')
    else
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def badge_type!(type)
    raise ArgumentError, 'Unknown badge type' unless Badge.types.include? type.to_sym

    type.constantize
  end

  def find_badge
    @badge = Badge.find(params[:id])
  end

  def badge_params
    params.require(:badge).permit(%i[title type image_name parameter_category_id parameter_number parameter_string])
  end

  def resque_with_argument_error(exception)
    render plain: exception.message, status: 400
  end
end
