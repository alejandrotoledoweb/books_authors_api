module AuthHelpers
  def auth_headers(user)
    token = AuthenticationTokenService.encode(user.id)
    { 'Authorization': "Bearer #{token}" }
  end
end
