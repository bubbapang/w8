class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :description
      t.boolean :secret
      t.references :author, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
