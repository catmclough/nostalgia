class CreateUsers < ActiveRecord::Migration
  def change
    create_table  :users do |t|
      t.string      :flickr_user_id
      t.string      :flickr_username
      t.string      :flickr_access_secret
      t.string      :flickr_access_token
      t.timestamps  null: false
    end
  end
end
