class TaskManager < ActiveRecord::Base
  self.abstract_class = true

  if Rails.env == "staging"
    establish_connection "task_manager_staging".to_sym
  else
    establish_connection "task_manager_#{Rails.env}".to_sym
  end

end
