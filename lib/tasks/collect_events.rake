# usage:
# rake csv:events:all => export all events to ./user.csv
# rake csv:events:last number=3   => export last 3 events
require 'csv' # according to your settings, you may or may not need this line

namespace :csv do
  namespace :events do
    desc "export all events to a csv file"
    task :all => :environment do
      export_to_csv Event.all
    end

    desc "export last #number events to a csv file"
    task :last => :environment do |task, arg|
      export_to_csv Event.last(ENV['number'].to_i)
    end

    def export_to_csv(events)
      CSV.open("./user.csv", "wb") do |csv|
        csv << Event.attribute_names
        events.each do |user|
          csv << user.attributes.values
        end
      end
    end
  end
end