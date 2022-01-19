class Post < ApplicationRecord
    validates :memo, {presence: true , length: {maximum: 140}}


    def user
        return User.find_by(id: self.user_id)
    end

end
