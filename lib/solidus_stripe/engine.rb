# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusStripe
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_stripe'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    paths["app/views"] << "lib/views/backend"
    paths["app/views"] << "lib/views/frontend"
    paths["app/views"] << "lib/views/api"

    initializer "spree.payment_method.add_stripe_credit_card", after: "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << "Spree::PaymentMethod::StripeCreditCard"
    end
  end
end
