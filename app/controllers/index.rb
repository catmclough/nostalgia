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
  @auth_flickr = FlickRaw::Flickr.new
  @auth_flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], params['oauth_verifier'])
  # attempt to find the user using the flickr id from our database
  user = User.find_by(flickr_user_id: @auth_flickr.test.login.id)
  # if we don't find a user, build one
  unless user
    user = User.new(flickr_user_id: @auth_flickr.test.login.id)
  end
  # then update the user (regardless of new or existing) with the access_token, access_secret, and username
  user.update_attributes(flickr_username: @auth_flickr.test.login.username, flickr_access_secret: @auth_flickr.access_secret, flickr_access_token: @auth_flickr.access_token)

  # log the user in
  session[:user_id] = user.id

  # redirect to somewhere else
  redirect '/photos'
end

get '/photos' do
  @photo_array = []
  @user = User.find(session[:user_id])
  @user.flickr_client
  # id = flickr.people.findByUsername(:username => "#{login.username}").id
  p = flickr.photos.search(:user_id => @user.flickr_user_id).each do |photo_object|
    @photo_array << photo_object
  end
    @p = @photo_array.sample
   # p info =  flickr.photos.getInfo("photo_id" => p.id)
   @photo_url = "http://farm#{@p.farm}.static.flickr.com/#{@p.server}/#{@p.id}_#{@p.secret}.jpg"
  erb :photo


end
