class CreateHeadlines < ActiveRecord::Migration[5.2]
  def change
    create_table :headlines do |t|
      t.string :string, limit: 250
      t.string :origin
      t.string :publisher
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
