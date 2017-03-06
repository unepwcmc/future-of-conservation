class ChangeShortCodeToShortName < ActiveRecord::Migration[5.0]
  def change
    rename_column :questions, :short_code, :short_name
  end
end
