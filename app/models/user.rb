class User < ActiveRecord::Base
  def flickr_client
    return @client if @client
    @client = FlickRaw::Flickr.new
    @client.access_token = flickr_access_token
    @client.access_secret = flickr_access_secret
    @client
  end
end
