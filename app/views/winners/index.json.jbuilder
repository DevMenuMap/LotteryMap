json.stores @winners do |winner|
	json.id winner.store.id
	json.name winner.store.name
	json.lat winner.store.lat
	json.lng winner.store.lng
end
