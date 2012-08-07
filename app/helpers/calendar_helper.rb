module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  def month_link_next(month_date)
    link_to("Next", {:month => month_date.month, :year => month_date.year})
  end
  def month_link_prev(month_date)
    link_to("Prev", {:month => month_date.month, :year => month_date.year})
  end
  
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link_prev(@shown_month.prev_month),
      :next_month_text => month_link_next(@shown_month.next_month) + " >>" ,
      
      :abbrev => true,
      :first_day_of_week => 0, # See note below when setting this
      :show_today => true,
      :show_header => true,
    
      # it would be nice to have these in the CSS file
      # but they are needed to perform height calculations
      :width => nil,
      :height => 500, 
      :day_names_height => 18,
      :day_nums_height => 18,
      :event_height => 18,
      :event_margin => 1,
      :event_padding_top => 1,
    
      :use_all_day => false,
      :use_javascript => true,
      :link_to_day_action => false
    }
  end

  def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      %(<a href="/events/#{event.id}" title="#{h(event.name)}">#{h(event.start_at.strftime('%l:%M'))}</a>)
    end
  end
end
