# frozen_string_literal: true

def process_login(_, response)
  random_string = SecureRandom.hex
  response.cookies.push WEBrick::Cookie.new(RubyOuath.configuration.cookie_name, random_string)

  params = {
    response_type: 'code',
    client_id: RubyOuath.configuration.client_id,
    scope: RubyOuath.configuration.scopes,
    redirect_uri: RubyOuath.configuration.callback_url,
    state: random_string
  }
  uri = URI('https://gitlab.com/oauth/authorize')
  uri.query = URI.encode_www_form(params)

  response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, uri.to_s)
end
