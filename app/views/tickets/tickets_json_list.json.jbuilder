json.records @tickets_hash[:records]
json.total @tickets_hash[:total]
json.page @tickets_hash[:page]
json.array!(@tickets_hash[:rows]) do |ticket|
  json.id ticket.id
  json.name ticket.name
  json.price ticket.price
  json.scenic ticket.scenic.name
  json.province ticket.province
  json.province_name BaseRegion.find(ticket.province).name
  json.city ticket.city
  json.city_name BaseRegion.find(ticket.city).name
  json.description ticket.description.html_safe
  json.status ticket.status
  json.ticket_type_id ticket.ticket_type_id
  json.created_at ticket.created_at
  json.picture ticket.picture
end