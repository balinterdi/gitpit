require "gitpit"

Gitpit::PivotalTracker.mode = :test if Rails.env.test?
