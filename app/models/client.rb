class Client < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable

  EMAIL_REGEX = /\A[^@\s]+@[^@\s]*\.[^@\s]*\z/

  # Relationships
  has_many :tickets, dependent: :destroy
  has_many :events, through: :tickets

  enum role: [:user, :admin]


  # Validations
  validates :email, uniqueness: true, presence: true, format: { with: EMAIL_REGEX, message: "must be a valid email format" }

  # Callbacks

  # Scopes

end