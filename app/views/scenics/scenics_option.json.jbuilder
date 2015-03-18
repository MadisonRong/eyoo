json.array!(@scenic_types) do |type|
	json.key type.id
	json.value type.name
end