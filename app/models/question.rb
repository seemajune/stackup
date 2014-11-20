class Question < ActiveRecord::Base
  validates_uniqueness_of :url #

  def self.get_questions
    path="questions/no-answers"
    #could be: answers, comments, tags, badges, users, events, info, posts, privileges, etc. ##https://api.stackexchange.com/docs
    todays_date=DateTime.now
    last_week=todays_date -7 # you can add and subtract days like this
    last_month=todays_date<<1 ##use << for month back, and >> for month forward: don't add days becuase the month before or after could be different form just 30 days apart
    # Time.new.to_i #1416453727 nanoseconds since the Unix epoch
    ##using one month ago to today
    from_date=last_week.to_time.to_i #convert from DateTime, to Time, and then to integer nanoseconds from the epoch for use in the api
    to_date=todays_date.to_time.to_i
    host_path={host: "api.stackexchange.com", path: "/2.2/#{path}"}
    query_params={key: "1iawbhuf9MxT2X77q)tvUA((", page: 1, pagesize: 100, order: "desc", sort: "activity", fromdate: "#{from_date}", todate: "#{to_date}", tagged: "ruby", site: "stackoverflow", filter: "!-*f(6rwhz2k1"}#this filter shows the total number of results in the hash

    uri=URI::HTTP.build(host_path)
    uri.query=URI.encode_www_form(query_params)
    response=Net::HTTP.get(URI(uri.to_s))
    data= JSON.parse(response)

    data["items"].each do |question|
      self.create(title: question["title"], url: question["link"], body_html: question["body"], body_md: question["body_markdown"])      
    end
     
    # user_requested_tags=["ruby", "html", "css", "javascript", "sql", "ruby-on-rails", "activerecord", "jQuery", "regex", "scrape"]

  end

end
