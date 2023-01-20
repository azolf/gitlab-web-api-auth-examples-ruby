# frozen_string_literal: true

def process_login(_, response)
  random_string = SecureRandom.hex
  response.cookies.push WEBrick::Cookie.new(RubyOuath.configuration.cookie_name, random_string)
  uri = RubyOuath::ProviderClient.redirect_uri(random_string)

  response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, uri.to_s)
end
