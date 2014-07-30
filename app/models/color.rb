class Color < ActiveRecord::Base
	belongs_to :palette
	acts_as_list scope: :palette

	validates :hex, presence: true, uniqueness: { scope: :palette_id }
end
