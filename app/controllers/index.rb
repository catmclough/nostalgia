get "/" do
  erb :index
end

FlickRaw.api_key= "04a77a5882d327512673de9a22bd2ced"
FlickRaw.shared_secret= "53ecc8bf225f3a63"
use Rack::Session::Pool

get '/authenticate' do
  token = flickr.get_request_token(:oauth_callback => to('check'))
  session[:token] = token
  redirect flickr.get_authorize_url(token['oauth_token'], :perms => 'read')
end


get '/check' do

  token = session.delete :token
  session[:auth_flickr] = @auth_flickr = FlickRaw::Flickr.new

  @auth_flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], params['oauth_verifier'])
  p @auth_flickr
  login = @auth_flickr.test.login
  %{
You are now authenticated as <em>#{login.username}</em>
with token <strong>#{@auth_flickr.access_token}</strong> and secret <strong>#{@auth_flickr.access_secret}</strong>.
  }
  # id = flickr.people.findByUsername(:username => "#{login.username}").id
  # flickr.photos.search(:user_id => id).each do |p|
  #   info = flickr.photos.getInfo(:photo_id => p.id)
  #   puts "Photo #{info}"
  # end
end

get '/session-viewer' do
  session.inspect
end
