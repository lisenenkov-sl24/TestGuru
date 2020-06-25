class Feedback
  include ActiveModel::AttributeAssignment
  include ActiveModel::Validations
  extend ActiveModel::Translation

  attr_accessor :name, :email, :message

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true

  def initialize(attributes = nil)
    assign_attributes(attributes) if attributes
  end
end
