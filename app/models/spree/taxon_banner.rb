module Spree
  class TaxonBanner < Asset
    include Rails.application.config.use_paperclip ? Configuration::Paperclip : Configuration::ActiveStorage
  end
end