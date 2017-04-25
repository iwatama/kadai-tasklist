class Task < ApplicationRecord
    validates :title ,presence:true,length:{maximum:100}
    validates :content ,presence:true,length:{maximum:255}
    validates :status ,presence:true,length:{maximum:10}
end
