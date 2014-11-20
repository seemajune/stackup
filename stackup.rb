require 'net/http'
require 'json'
require 'pry'
require 'date'
# uri.to_s equivalent to uri.scheme+uri.host+uri.path+uri.query+uri.fragment#total query
#scheme: http, #host: api.stackexchange.com, #path: /2.2/questions, #query: page=1&pagesize=1&order=desc&sort=activity&site=stackoverflow&filter=%219YdnSNNB1, #fragment: nil
SOAPIpath="questions"#could be: answers, comments, tags, badges, users, events, info, posts, privileges, etc. ##https://api.stackexchange.com/docs
todays_date=DateTime.now
last_week=todays_date -7 # you can add and subtract days like this
last_month=todays_date<<1 ##use << for month back, and >> for month forward: don't add days becuase the month before or after could be different form just 30 days apart
# Time.new.to_i #1416453727 nanoseconds since the Unix epoch
##using one month ago to today
from_date=last_month.to_time.to_i #convert from DateTime, to Time, and then to integer nanoseconds from the epoch for use in the api
to_date=todays_date.to_time.to_i
host_path={host: "api.stackexchange.com", path: "/2.2/#{SOAPIpath}"}
query_params={key: "1iawbhuf9MxT2X77q)tvUA((", page: 1, pagesize: 5, order: "desc", sort: "activity", fromdate: "#{from_date}", todate: "#{to_date}", site: "stackoverflow", filter: "!9YdnSNNB1"}#this filter shows the total number of results in the hash
uri=URI::HTTP.build(host_path)
uri.query=URI.encode_www_form(query_params)
response=Net::HTTP.get(URI(uri.to_s))
data= JSON.parse(response)


user_requested_tags=["ruby", "html", "css", "javascript", "sql", "ruby-on-rails", "activerecord", "jQuery", "regex", "scrape"]

##epoch nanoseconds >> Time object >> string from Time >> Date object >> string from Date, ex: "2014-11-19"
def get_date_from_epoch_time(epoch_time_in_secs)
  Date.parse(Time.at(epoch_time_in_secs).to_s).to_s
end

def collect_questions_with_tags(data)
  data.each do |item|
    puts item
  end
end
binding.pry

# syntax 
# parameter-passing
# block
# migration
# scaffolding
# rubygems
# rvm


# Example of 1 item
# {
#   "items": [
#     {
#       "tags": [
#         "html",
#         "css",
#         "html5",
#         "spacing"
#       ],
#       "owner": {
#         "reputation": 662,
#         "user_id": 3390466,
#         "user_type": "registered",
#         "accept_rate": 100,
#         "profile_image": "http://i.stack.imgur.com/itZmL.png?s=128&g=1",
#         "display_name": "Victor2748",
#         "link": "http://stackoverflow.com/users/3390466/victor2748"
#       },
#       "is_answered": false,
#       "view_count": 1,
#       "answer_count": 0,
#       "score": 0,
#       "last_activity_date": 1416448623,
#       "creation_date": 1416448623,
#       "question_id": 27030446,
#       "link": "http://stackoverflow.com/questions/27030446/html5-ul-li-forced-spacing",
#       "title": "HTML5: UL-LI forced spacing?"
#     }
#   ],
#   "has_more": true,## more pages available
#   "quota_max": 10000,
#   "quota_remaining": 9991
# } 