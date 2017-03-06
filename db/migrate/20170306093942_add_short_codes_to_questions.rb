class AddShortCodesToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :short_code, :string
  end
end
