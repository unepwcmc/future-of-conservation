class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :text
      t.float :weight
      t.string :axis

      t.timestamps
    end
  end
end
