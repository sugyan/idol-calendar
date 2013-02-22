class Event < Sequel::Model
  unrestrict_primary_key
  many_to_one :calendar
end
