module Synergy
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'synergy'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      I18n.default_locale = :ru
      Spree::Config.default_country_id = 168
      Spree::Config.currency = 'RUB'
    end

    config.to_prepare &method(:activate).to_proc
  end
end
