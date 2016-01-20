class AddToForms < ActiveRecord::Migration
  def change
    add_column :forms, :data_two, :binary
  end
end
