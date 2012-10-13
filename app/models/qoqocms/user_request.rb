module Qoqocms
	class UserRequest < ActiveRecord::Base
	  apply_simple_captcha

	  attr_accessible :name, :email, :phones, :message

	  validates :name, :email, :message, :presence => true

	  scope :ordered, order('created_at DESC')
	end
end