get "/" do
  erb :index
end

get "/home" do
  @frob = params[:frob]
  erb :index
end
