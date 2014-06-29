json.array!(@coloritems) do |coloritem|
  json.extract! coloritem, :id, :name, :hex, :mixed, :order, :palette_id
  json.url coloritem_url(coloritem, format: :json)
end
