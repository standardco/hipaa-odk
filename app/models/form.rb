class Form < ActiveRecord::Base
  has_encrypted_column :data

end
