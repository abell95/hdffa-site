json.extract! provider, :id, :name, :description, :street_address, :city, :state, :zip, :email, :latitude, :longitude, :created_at, :updated_at
json.url provider_url(provider, format: :json)
