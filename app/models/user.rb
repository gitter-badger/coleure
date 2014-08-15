require "bcrypt"

class User < ActiveRecord::Base
  validates :name,  presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  has_many :palettes

  def leaf_palettes
    sql = "
      WITH RECURSIVE parent_palettes(id, user_id, children_count) AS (
        SELECT p.id, p.user_id, 0
        FROM   palettes p
        WHERE  p.parent_id IS NULL
      UNION ALL
        SELECT p.id, p.user_id, pp.children_count + 1
        FROM   palettes p, parent_palettes pp
        WHERE  p.parent_id = pp.id
      )

      SELECT id
      FROM   parent_palettes
      WHERE  children_count = 0
      AND    user_id = ?
    "

    palettes.where "id IN (#{ sql })", id
  end
end
