class Event < ApplicationRecord
   # Relationships
   has_many :tickets, dependent: :destroy
   belongs_to :admin, class_name: 'Client', foreign_key: 'admin_id', optional: true
  
   enum :status, [:soon, :available, :sold]
 
   # enum status: { soon: 0, available: 1, sold: 2 }
 
   # Validations
   validates :description, length: { in: 10..300, message: "must be between 10 and 300 characters" }
 
   # Callbacks
   #after_create :send_welcome_email
   before_save :set_status_available
   after_save :set_status_sold_out
  
   # Scopes
   scope :soon, -> { where(status: :soon)}
   scope :available, -> { where(status: :available)}
   scope :sold, -> { where(status: :sold)}
   scope :by_status, ->(status) { where(status: statuses[status]) if status.present? }
   #scope :by_status, ->(status) { where(status:status) if status.present? }
 
 
   private 
  

   # Set status "available" if the event has an `event_date`
   def set_status_available
     self.status = :available if event_date.present? && status == "soon"
   end  
 
   # Set status to "sold"
   def set_status_sold_out
     if tickets.count >= capacity
       update_column(:status, "sold") # update_column to bypass | callbacks and validations
     end  
   end  
end
