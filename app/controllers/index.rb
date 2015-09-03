get "/" do
  erb :index
end

get '/auth/flickr/callback' do
  @user_hash = env['omniauth.auth']
  erb :index
end
