class ChangeStatus2DataTypeInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :status, :string
  end
end
