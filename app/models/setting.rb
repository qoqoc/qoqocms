class Setting < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  CACHE_KEY = 'Setting_%s'
  after_save :_clear_cache

  class << self
    def get(name, default)
      val = Rails.cache.fetch(CACHE_KEY % name) {
        setting = Setting.find_or_initialize_by_name(name)
        if setting.new_record?
          setting.value = default
          setting.save
        end
        setting.value
      }
      Rails.cache.delete(CACHE_KEY % name) if val.nil?
      val || default
    end
  end

private
  def _clear_cache
    Rails.cache.delete(CACHE_KEY % self.name) rescue nil
  end
end
