require 'rubygems'
require 'locomotive_plugins'
require 'twitter'
require 'twitter_plugin/blocks'

module TwitterPlugin
  class TwitterPlugin
    include Locomotive::Plugin

    before_page_render :set_config

    def self.default_plugin_id
      'twitter'
    end

    def self.liquid_tags
      {
        :search => Search
      }
    end

    def config_template_file
      File.join(File.dirname(__FILE__), 'twitter_plugin', 'configUI.haml')
    end

    protected

    def set_config
      ui_config = config
      Twitter.configure do |conf|
        conf.consumer_key = ui_config['consumer_key']
        conf.consumer_secret = ui_config['consumer_secret']
        conf.oauth_token = ui_config['access_token']
        conf.oauth_token_secret = ui_config['access_token_secret']
      end
    end
  end
end
