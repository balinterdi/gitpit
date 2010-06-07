require "gitpit"

if Rails.env.test?
  Gitpit::PivotalTracker.mode = :test
else
  Gitpit::PivotalTracker.mode = :production
end
