namespace :camp do
  task :random_events => :environment do
    Camp.all.each do |camp|
      start_at = Time.now
      day      = 60 * 60 * 24
      ages     = %w/1-5 6-8 8-9 8-12 8-14 8-16 10-14 10-16 6-16 9-16 12-18 14-18/
      genders  = %w/boys girls coed/
      0.upto(24).each do |i|
        start_at  += (day * rand() * 31).to_i
        end_at     = start_at + (day * (rand() > 0.5 ? 7 : 14))
        gender     = genders[ (rand() * genders.length).to_i ]
        age        = ages[ (rand() * ages.length).to_i ]
        name       = start_at.strftime("%B %e Session")
        STDERR.puts "#{camp.id}:#{name}:#{gender}:#{age}: #{start_at.strftime("%Y-%m-%d")} -> #{end_at.strftime("%Y-%m-%d")}"
        Event.create(
          :start_at => start_at,
          :end_at   => end_at,
          :name     => name,
          :gender   => gender,
          :ages     => age,
          :camp_id  => camp.id
        )
      end
    end
  end
end
