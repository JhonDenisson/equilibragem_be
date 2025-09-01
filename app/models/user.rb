class User < ApplicationRecord
  has_secure_password
  has_many :transactions
  has_many :categories
  has_many :allocation_rules
  has_many :summaries

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 10 }

  before_save :downcase_email

  private
  def downcase_email
    self.email = email&.downcase
  end
end
