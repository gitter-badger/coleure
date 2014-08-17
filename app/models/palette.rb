class Palette < ActiveRecord::Base
	has_many :colors, -> { order("position ASC") }

	def self.with_color(params)
		old_palette = find(params[:palette_id]) if params[:palette_id]
		new_palette = create

		if old_palette
			old_palette.colors.each { |c| new_palette.colors.create(name: c.name, hex: c.hex, rgb: c.rgb, hsl: c.hsl, mixed: c.mixed) }
		end

		new_palette.colors.create(name: params[:name], hex: params[:hex], rgb: params[:rgb], hsl: params[:hsl], mixed: params[:mixed])

		new_palette
	end

	def without_color(hex)
		new_palette = self.class.create

		colors.each { |c| new_palette.colors.create(name: c.name, hex: c.hex, rgb: c.rgb, hsl: c.hsl, mixed: c.mixed) unless c.hex == hex }

		new_palette
	end
end
