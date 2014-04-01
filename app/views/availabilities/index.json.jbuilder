json.array!(@availabilities) do |availability|
  json.extract! availability, :id, :from, :to
  json.url availability_url(availability, format: :json)
end
