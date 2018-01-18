class RemovePhoneFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :phone, :string
  end
end
