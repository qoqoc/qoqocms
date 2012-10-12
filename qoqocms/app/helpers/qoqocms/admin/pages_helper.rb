module Qoqocms
	module Admin::PagesHelper
	  def options_for_pages
	    [['','']] + nested_set_options(Page, @page) {|i| "#{'-' * i.level} #{i.title}" }
	  end
	end
end