class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.jsonb :data
    end
  end
end
