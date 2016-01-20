class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.binary :data
    end
  end
end
