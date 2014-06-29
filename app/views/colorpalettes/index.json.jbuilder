json.array!(@colorpalettes) do |colorpalette|
  json.extract! colorpalette, :id, :name
  json.url colorpalette_url(colorpalette, format: :json)
end
