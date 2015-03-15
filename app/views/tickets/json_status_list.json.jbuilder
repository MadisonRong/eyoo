json.array!(@commodity) do |commodity|
	json.extract! commodity, :id, :name, :price, :scenic, :description, :ticket_type, :created_at
end