require 'bundler'
require 'sequel'
require 'logger'

STATISTICS_CSV = File.expand_path("~/.omnifocus-stats.csv")
dbname =  File.expand_path("~/Library/Caches/com.omnigroup.OmniFocus/OmniFocusDatabase2")
DB = Sequel.sqlite(dbname)

date = Date.today-1

completed_task_count =  DB[:Task].where(%Q{projectInfo IS NULL AND dateCompleted BETWEEN strftime('%s','#{date.to_s}')-strftime('%s','2001-01-01') AND strftime('%s','#{(date+1).to_s}')-strftime('%s','2001-01-01')}).count
completed_project_count =  DB[:Task].where(%Q{projectInfo IS NOT NULL AND dateCompleted BETWEEN strftime('%s','#{date.to_s}')-strftime('%s','2001-01-01') AND strftime('%s','#{(date+1).to_s}')-strftime('%s','2001-01-01')}).count

File.open(STATISTICS_CSV, 'a') do |f|
  f.puts "#{date.to_s},#{completed_task_count},#{completed_project_count}"
end