require 'bundler'
require 'sequel'
require 'logger'

dbname =  File.expand_path("~/Library/Caches/com.omnigroup.OmniFocus/OmniFocusDatabase2")
DB = Sequel.sqlite(dbname)

date = Date.today

stale_tasks = DB[:Task].where(%Q{projectInfo IS NULL AND dateCompleted IS NULL AND dateModified < strftime('%s','#{(date-14).to_s}')-strftime('%s','2001-01-01')})
stale_tasks.update(flagged: 1, effectiveFlagged: 1)
