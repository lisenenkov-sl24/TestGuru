class BadgesController < ApplicationController
  def index
    @awarded_badges = current_user.user_badges.includes(:badge).order(:created_at)
    @not_awarded_badges = Badge.where.not(id: @awarded_badges.map {|b| b.badge_id} ) 
  end
end
