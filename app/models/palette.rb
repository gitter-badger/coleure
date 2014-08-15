class Palette < ActiveRecord::Base
	belongs_to :user

	belongs_to :parent,   class_name: self, foreign_key: :parent_id
	has_many   :children, class_name: self, foreign_key: :parent_id, dependent: :destroy

	has_many :colors, -> { order("position ASC") }

	def leafs
		sql = "
			WITH RECURSIVE parent_palettes(id, children_count) AS (
				SELECT p.id, 0
				FROM 	 palettes p
				WHERE  p.id = ?
			UNION ALL
				SELECT p.id, pp.children_count + 1
				FROM   palettes p, parent_palettes pp
				WHERE  p.parent_id = pp.id
			)

			SELECT id
			FROM   parent_palettes
			WHERE  children_count = 0
		"

		self.class.where "id IN (#{ sql })", id
	end

	def self.with_color(params)
		old_palette = find(params[:palette_id]) if params[:palette_id]
		new_palette = create user_id: params.delete(:user_id), parent_id: old_palette.try(:id)

		if old_palette
			old_palette.colors.each do |c|
				new_palette.colors.create(name: c.name, hex: c.hex, rgb: c.rgb, hsl: c.hsl, mixed: c.mixed)
			end
		end

		new_palette.colors.create(name: params[:name], hex: params[:hex], rgb: params[:rgb],
															hsl: params[:hsl], mixed: params[:mixed])

		new_palette
	end

	def without_color(hex)
		new_palette = self.class.create

		colors.each do |c|
			new_palette.colors.create(name: c.name, hex: c.hex, rgb: c.rgb, hsl: c.hsl, mixed: c.mixed) unless c.hex == hex
		end

		new_palette
	end
end
