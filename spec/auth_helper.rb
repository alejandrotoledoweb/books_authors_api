module AuthHelper
  def auth_headers(user)
    token = AuthenticationTokenService.encode(user.id)
    # token
    { 'Authorization': "Bearer #{token}" }
  end

  def token(user)
    token = AuthenticationTokenService.encode(user.id)
    token
  end
end
