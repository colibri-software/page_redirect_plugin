require 'rubygems'
require 'locomotive_plugins'
require 'redirects'

module PageRedirectPlugin
  class PageRedirectPlugin
    include Locomotive::Plugin

    before_page_render :set_config

    def config_template_file
      File.join(File.dirname(__FILE__), 'page_redirect_plugin', 'configUI.haml')
    end

    protected

    # gets run before every page render
    def set_config
      ui_config = config
      set_model_sites
      Redirects._model_slug = config['redirect_model_slug']
      redirect
    end

    # gets the current site
    def get_site
      controller.send(:current_site)
    end
    
    # sets the current site on the wrapper models for locomotive.
    def set_model_sites
      models = [Redirects]
      models.each { |model| model._site = get_site }
    end

    # loops through all the redirect entries from the given model
    # and checks if the fullpath match the regex given and will
    # redirect to the given url.
    def redirect
      Redirects.entries.each do |entry|
        rules = entry.custom_fields_recipe['rules']
        match = entry[rules.first['name']]
        redirect_url = entry[rules.last['name']]
        if controller.request.fullpath =~ /#{match}/
          controller.redirect_to redirect_url
        end
      end
    end
  end
end
