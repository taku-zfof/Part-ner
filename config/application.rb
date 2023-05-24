require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PartNer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.i18n.default_locale = :ja # I18nライブラリに訳文の探索場所を指示する
    # config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]
    config.time_zone = 'Tokyo' #タイムゾーンを日本時間に

    config.paths.add 'lib', eager_load: true #バッチ処理用の有効化


    #バリデーションエラー時にレイアウトが崩れないようにする記述
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        Nokogiri::HTML.fragment(html_tag).search('input', 'textarea', 'select').add_class('is-error').to_html.html_safe
      end
    end
    #バリデーションエラー時にレイアウトが崩れないようにする記述

  end
end
