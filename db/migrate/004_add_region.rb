Sequel.migration do
  change do
    alter_table :calendars do
      add_column :area, String
    end
  end
end
