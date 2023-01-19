def process_refresh_token(request, response)
  url = 'https://gitlab.com/oauth/token'
  data = {
    refresh_token: request.query['refresh_token'],
    grant_type: 'refresh_token',
    client_id: RubyOuath.configuration.client_id,
    client_secret: RubyOuath.configuration.client_secret
  }
  res = RestClient.post url,
    data,
    {
      accept: :json
    }

    render_json(res.body, response)
end
