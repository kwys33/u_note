class User < ApplicationRecord
    validates :name,{presence: true}
    validates :email,{uniqueness: true,presence: true}
    validates :password,{presence: true}
    validate :if_postalcode_not_found



    def if_postalcode_not_found
        if self.postalcode.present?
            base_url = "https://zipcloud.ibsnet.co.jp/api/search"
            response = open(base_url + "?zipcode=#{self.postalcode}")
            results = JSON.parse(response.read)
            if results ["status"] != 200
                errors.add(:postalcode,"存在しない郵便番号")
            end
        end
    end
end