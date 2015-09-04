get "/" do
  erb :index
end

get "/callback" do
  @frob = params[:frob]
  @api_key = "04a77a5882d327512673de9a22bd2ced"
  secret = "53ecc8bf225f3a63"
  sig = secret + "api_key" + api_key + "frob" + frob + "methodflickr.auth.getToken"
  @sig_key = Digest::MD5.hexdigest(sig)
  erb :show
end
