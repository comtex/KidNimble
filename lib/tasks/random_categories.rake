namespace :camp do
  task :random_categories => :environment do
    Camp.all.each do |camp|
      amt = (rand(5) + 1).to_i
      0.upto(amt) do |i|
        offset      = rand(Subs.count)
        sub = Subs.first(:offset => offset)
        STDERR.puts "#{i}: #{camp.id}: #{sub.name}"
        camp.subs << sub
      end
    end
  end
end
