class FixHeadlinesColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :headlines, :string, :text
  end
end
