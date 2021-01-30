json.extract! task, :id, :name, :duedate, :worktype, :description, :created_at, :updated_at
json.url task_url(task, format: :json)
