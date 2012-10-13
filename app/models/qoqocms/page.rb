module Qoqocms
  class Page < ActiveRecord::Base
    include ActiveSupport::Inflector

    attr_accessible :parent_id, :url, :title, :active, :body

    acts_as_nested_set

    validates :title, :url, :presence => true
    before_validation :_set_default_url, :_normalize_url

    scope :ordered, order('lft')
    scope :active, where(:active => true)
    # scope :for_menu, where(:on_left => false).active
    # scope :for_left_menu, where(:on_left => true).active

    class << self
      def normalize_url(url)
        "/"+url.gsub(/(.*?)[\?#].*/,'\1').gsub(/^\/+(.*)/,'\1').gsub(' ', '_')
      end
    end

    def full_url
      "#{self.url}"
    end

    private

    def _set_default_url
      self.url = transliterate(title.mb_chars.downcase) if self.url.blank?
    end

    def _normalize_url
      self.url = self.class.normalize_url(self.url)
    end

  end
end