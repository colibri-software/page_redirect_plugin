module PageRedirectPlugin
  class Redirects
    extend ::LocomotiveModelWrapper

    def self._model_slug
      @@model_slug  
    end
    
    def self._site
      @@site || ::Locomotive::Site.first
    end

    def self._site=(site)
      @@site = site
    end

    def self._model_slug=(model_slug)
      @@model_slug = model_slug
    end
  end
end

