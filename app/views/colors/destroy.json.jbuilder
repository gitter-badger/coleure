Jbuilder.encode do |json|
  json.id       @palette.id
  json.comments @palette.colors, :name, :hex, :rgb, :hsl, :mixed
end
