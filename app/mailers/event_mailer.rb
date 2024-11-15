class EventMailer < ApplicationMailer
  default from: 'equipo.tudestino@gmail.com'


  def event_created_email(client, event)
    @client = client
    @event = event

    mail(
      to: @client.email,
      subject: "Event '#{event.event_name}' Created at '#{event.event_date || event.status}' with capacity of '#{event.capacity}'"
    )
  end
end