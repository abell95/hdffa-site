class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :body
      t.references :partner, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
