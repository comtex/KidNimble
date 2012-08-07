namespace :camp do
  task :random_activities => :environment do
    activities = %w/camping hunting fishing boating football basketball tennis/
    Camp.all.each do |camp|
      here = activities.shuffle
      num = (rand() * activities.length).to_i
      0.upto( (rand() * activities.length).to_i ).each do |i|
        Activity.create(:camp_id => camp.id, :kind => here[i])
      end
    end
  end
end
