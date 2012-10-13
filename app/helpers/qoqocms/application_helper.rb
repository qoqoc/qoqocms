module Qoqocms
  module ApplicationHelper
  	def menu_pages
    	::Qoqocms::Page.roots.ordered.active
  	end
  end
end
