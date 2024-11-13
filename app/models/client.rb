class Client < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]*\.[^@\s]*\z/

  # Relationships
  has_many :tickets, dependent: :destroy

  # Validations
  validates :mail, uniqueness: true, presence: true, format: { with: EMAIL_REGEX, message: "must be a valid email format" }

  # Callbacks

  # Scopes


end
