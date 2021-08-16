json.extract! patient, :id, :name, :login, :is_admin, :created_at, :updated_at
json.url patient_url(patient, format: :json)
