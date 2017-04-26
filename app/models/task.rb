class Task < ApplicationRecord
    belongs_to :user

    validates :user_id, presence: true
    validates :title ,presence:true,length:{maximum:100}
    validates :content ,presence:true,length:{maximum:255}
    validates :status ,presence:true,length:{maximum:10}
end
