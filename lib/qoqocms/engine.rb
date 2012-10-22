module Qoqocms
  class Engine < ::Rails::Engine
    isolate_namespace Qoqocms
    engine_name :qoqocms

    initializer 'qoqocms.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Qoqocms::Engine.helpers
      end
    end
  end
end
