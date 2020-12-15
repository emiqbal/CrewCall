
class ProducersCalendar < SimpleCalendar::MonthCalendar
  def td_classes_for(day)
    td_class = super
    unless sorted_events[day].empty?
      case sorted_events[day].first.color
      when 1
        td_class << 'project-a'
      when 2
        td_class << 'project-b'
      when 3
        td_class << 'project-a'
      when 4
        td_class << 'project-b'
      end
    end

    td_class
  end
end

