class ChangeStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :status, :integer, default: 0
  end
end
