class AddLastLoginTimeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_login_time, :datetime
  end
end
