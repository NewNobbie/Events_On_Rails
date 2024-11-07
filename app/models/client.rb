class Client < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validates :mail, uniqueness: true, presence: true

end
