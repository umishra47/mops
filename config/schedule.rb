# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :environment, :development
set :output, 'log/file.log'

every :day, :at => '1200am'do
  rake "job_scheduler:send_renew_alert"
end


every 1.day, :at => '12:01 am' do
	rake "job_scheduler:making_dump"
end

every 1.month, :at => '12:01 am' do
	rake "job_scheduler:deleting_dump"
end

