require "bcrypt"

class User < ActiveRecord::Base
  validates :name,  presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  has_many :palettes

  def leaf_palettes
    sql = "
      WITH RECURSIVE parent_palettes(id, children_count) AS (
        SELECT p.id, 0
        FROM   palettes p
        WHERE  p.user_id = ?
      UNION ALL
        SELECT p.id, pp.children_count + 1
        FROM   palettes p, parent_palettes pp
        WHERE  p.parent_id = pp.id
      )

      SELECT id
      FROM   parent_palettes
      WHERE  children_count = 0
    "

    Palette.where "id IN (#{ sql })", id
  end
end
