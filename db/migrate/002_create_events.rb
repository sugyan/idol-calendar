Sequel.migration do
  up do
    create_table :events do
      String   :id, :primary_key => true
      Integer  :calendar_id
      DateTime :created
      DateTime :updated
      DateTime :start
      DateTime :end
      String   :summary
      String   :description
      String   :location
      String   :htmlLink
    end
  end

  down do
    drop_table :events
  end
end
