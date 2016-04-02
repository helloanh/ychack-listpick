module ApplicationHelper
    def alert_type(name)
      case name
      when :notice
        "success"
      when :error
        "danger"
      when :danger
        "danger"
      when :warning
        "warning"
      else
        "info"
      end
    end
end
