module RubyOuath
  class ProviderClient
    def self.redirect_uri(state)
      params = {
        response_type: 'code',
        client_id: RubyOuath.configuration.client_id,
        scope: RubyOuath.configuration.scopes,
        redirect_uri: RubyOuath.configuration.callback_url,
        state: state
      }
      uri = URI('https://gitlab.com/oauth/authorize')
      uri.query = URI.encode_www_form(params)
      
      uri
    end
  end
end