module ApplicationHelper

  # Flash message to Bootstrap alert
  def change_bootstrap_key(key)
    case key
    when 'notice' then 'info'
    when 'alert' then 'danger'
    else key
    end
  end
  
end
