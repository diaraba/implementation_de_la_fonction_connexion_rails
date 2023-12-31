class User < ApplicationRecord
    validates:name, presence:true,length: {maximum:30}
    validates:email, presence:true,length: {maximum:255},uniqueness:true,format:{with:  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
    has_many :tasks, dependent: :destroy
    has_secure_password
    validates:password,length:{minimum:6}
end
