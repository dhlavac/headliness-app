class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :author
      t.text :text
      t.datetime :created_at
      t.integer :up_vote
      t.integer :down_vote
      t.references :headline, foreign_key: true

      t.timestamps
    end
  end
end
