json.extract! customer, :id, :first_name, :last_name, :birthyear, :avatar, :contact, :created_at, :updated_at
json.url customer_url(customer, format: :json)
