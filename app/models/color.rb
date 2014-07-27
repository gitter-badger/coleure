class Color < ActiveRecord::Base
	belongs_to :palette

	validates :hex, presence: true, uniqueness: { scope: :palette_id }
end
