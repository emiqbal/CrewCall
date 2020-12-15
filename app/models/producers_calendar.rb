
class ProducersCalendar < SimpleCalendar::MonthCalendar
  def td_classes_for(day)
    td_class = super
    unless sorted_events[day].empty?
      start_day = sorted_events[day].first.start_date
      # temp solution
      if start_day.monday? || start_day.wednesday? || start_day.saturday?
        td_class << 'project-a'
      else
        td_class << 'project-b'
      end
    end

    td_class
  end
end

