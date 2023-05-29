# frozen_string_literal: true

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

# 毎朝７時に呼び出しバッチ処理を動かす
require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = Rails.env.to_sym
set :environment, rails_env
set :output, "log/cron.log"
ENV.each { |k, v| env(k, v) } # Docker上でcronを動かすための記述

every 1.day, :at => "7:00" do
  begin
    runner "Batch::Call.call"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end