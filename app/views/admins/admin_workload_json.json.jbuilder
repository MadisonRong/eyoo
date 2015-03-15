json.array!(@admins) do |admin|
	json.extract! admin, :id, :name, :y
end