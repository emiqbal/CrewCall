
class UserJobsCalendar < SimpleCalendar::MonthCalendar
  def td_classes_for(day)
    td_class = super
    unless sorted_events[day].empty?
      case sorted_events[day].first.status
      when 'Confirmed'
        td_class << 'project-confirmed'
      when 'Rejected'
        td_class << 'project-rejected'
      when 'Approved'
        td_class << 'project-approved'
      when 'Applied'
        td_class << 'project-applied'
      end
    end

    td_class
  end
end
