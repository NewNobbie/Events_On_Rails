class Ticket < ApplicationRecord
  # Relationships
  belongs_to :event
  belongs_to :client

  # Validations
  validate :check_event_capacity, on: :create
  # Callbacks

  # Scopes 

  private
  
  def check_event_capacity
    if event.tickets.count >= event.capacity
      errors.add(:base, "Event has reached its capacity")
    end  
  end
end
