# frozen_string_literal: true

def process_callback(request, response)
  state_cookie = cookie(request, RubyOuath.configuration.cookie_name)
  raise 'error' unless state_cookie.value == request.query['state']

  data = {
    code: request.query['code'],
    redirect_uri: RubyOuath.configuration.callback_url,
    client_id: RubyOuath.configuration.client_id,
    client_secret: RubyOuath.configuration.client_secret,
    grant_type: 'authorization_code'
  }

  res = RestClient.post(
    'https://gitlab.com/oauth/token',
    data,
    {
      accept: :json
    }
  )

  result = JSON.parse(res.body)

  params = {
    access_token: result['access_token'],
    refresh_token: result['refresh_token']
  }
  uri = URI('/me')
  uri.query = URI.encode_www_form(params)

  response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, uri.to_s)
end
