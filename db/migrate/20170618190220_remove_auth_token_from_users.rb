class RemoveAuthTokenFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :auth_token
  end
end
