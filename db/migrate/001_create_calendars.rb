Sequel.migration do
  up do
    create_table :calendars do
      primary_key :id
      String :cid, :unique => true
      String :summary
      String :description
    end
  end

  down do
    drop_table :calendars
  end
end
