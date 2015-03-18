json.array!(@ticket_types) do |type|
	json.key type.id
	json.value type.name
end