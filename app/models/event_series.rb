# == Schema Information
# Schema version: 20100330111833
#
# Table name: event_series
#
#  id         :integer(4)      not null, primary key
#  frequency  :integer(4)      default(1)
#  period     :string(255)     default("months")
#  starttime  :datetime
#  endtime    :datetime
#  all_day    :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#

class EventSeries < ActiveRecord::Base
  END_TIME = Date.parse("1 Jan, 2020").to_time
  attr_accessor :title, :description, :commit_button
  
  validates_presence_of :frequency, :period, :starttime, :endtime
  validates_presence_of :title, :description
  
  has_many :events, :dependent => :destroy
  after_save :create_events_until

  
  def create_events_until
    st = starttime
    et = endtime
    p = r_period(period)
    nst, net = st, et

    while frequency.send(p).from_now(st) <= endtil.send(p).from_now
      puts "#{nst}           :::::::::          #{net}" if nst and net
      self.events.create(:user_id => user_id, :group_id => group_id, :title => title, :description => description, :all_day => all_day, :starttime => nst, :endtime => net)
      nst = st = frequency.send(p).from_now(st)
      net = et = frequency.send(p).from_now(et)
      
      if period.downcase == 'monthly' or period.downcase == 'yearly'
        begin 
          nst = DateTime.parse("#{starttime.hour}:#{starttime.min}:#{starttime.sec}, #{starttime.day}-#{st.month}-#{st.year}")  
          net = DateTime.parse("#{endtime.hour}:#{endtime.min}:#{endtime.sec}, #{endtime.day}-#{et.month}-#{et.year}")
        rescue
          nst = net = nil
        end
      end
    end
  end
  
  def r_period(period)
    case period
      when 'Daily'
      p = 'days'
      when "Weekly"
      p = 'weeks'
      when "Monthly"
      p = 'months'
      when "Yearly"
      p = 'years'
    end
    return p
  end
  
end
