Sequel.migration do
  change do
    alter_table :events do
      add_column :last_updated, DateTime
      add_index :start
    end
  end
end
