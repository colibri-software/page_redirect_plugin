module TwitterPlugin
  class Search < Liquid::Block
   
    Syntax = /(#{::Liquid::QuotedString}|#{::Liquid::VariableSignature}+)/
    
    def initialize(tag_name, markup, tokens, context)
      @options = {}
      if markup =~ Syntax
        @search = $1
        @search_is_var = false

        if @search.match(::Liquid::QuotedString)
          @search.gsub!(/['"]/, '')
        elsif @search.match(::Liquid::VariableSignature)
          @search_is_var = true
        end

        markup.scan(::Liquid::TagAttributes) do |key, value|
          @options[key.to_sym] = value.gsub(/"|'/, '')
        end
      else
        raise ::Liquid::SyntaxError.new("Syntax Error in 'search' - Valid Synstax: search <search string> <options>")
      end
      super
    end
    
    def render(context)
      if @search_is_var
        search = context[@search]
      else
        search = @search
      end
      
      @results = Twitter.search(search, @options).results.map { |tweet| 
        {"text" => tweet.text, "id" => tweet.id, "created_at" =>  tweet.created_at} }
      context.stack do
        context.scopes.last["search_results"] = @results
        render_all(@nodelist, context)
      end
    end

    def render_disabled(context)
      render_all(@nodelist, context)
    end
  end
end
