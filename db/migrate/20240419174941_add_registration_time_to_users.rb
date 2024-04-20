class AddRegistrationTimeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :registration_time, :datetime
  end
end
