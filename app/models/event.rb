class Event < ApplicationRecord
  has_many :tickets, dependent: :
  
  enum status: { soon: 0, available: 1, sold: 2 }
end
