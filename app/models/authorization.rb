class Authorization
  include Guachiman

  def initialize(user)
    if @current_user = user
      user_authorization
    else
      guest_authorization
    end
  end

private

  def guest_authorization
    allow :sessions, %i[new create destroy]
    allow :palettes, %i[index new, create show edit]
    allow :colors,   %i[create destroy]
    allow :users,    %i[new create]
  end

  def user_authorization
    guest_authorization

    allow :users, %i[new create] do |user|
      @current_user.id == user.id
    end
  end
end
