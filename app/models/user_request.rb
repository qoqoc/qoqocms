class UserRequest < ActiveRecord::Base
  apply_simple_captcha
  
  validates :name, :message, :phones, :presence => true

  scope :ordered, order('created_at DESC')
end
