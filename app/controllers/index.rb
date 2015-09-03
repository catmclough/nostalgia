get "/" do
  erb :index
end

get '/auth/flickr/callback' do
  erb :index
end
