class User < ApplicationRecord
  has_one :email_sign_in
end
