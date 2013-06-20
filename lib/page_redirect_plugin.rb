require 'rubygems'
require 'locomotive_plugins'

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
      redirect
    end

    # gets the current site
    def get_site
      controller.send(:current_site)
    end

    # gets the model and it needs for the redirects
    def get_model(model_slug)
      site = get_site
      site.content_types.where(:slug => model_slug).first
    end

    # loops through all the redirect entries from the given model
    # and checks if the fullpath match the regex given and will
    # redirect to the given url.
    def redirect
      redirect_model = get_model(config['redirect_model_slug'])
      if redirect_model
        redirect_model.entries.each do |entry|
          rules = entry.custom_fields_recipe['rules']
          match = entry[rules.first['name']]
          redirect_url = entry[rules.last['name']]
          if controller.request.fullpath =~ /#{match}/
            controller.redirect_to redirect_url and return
          end
        end
      end
    end
  end
end
