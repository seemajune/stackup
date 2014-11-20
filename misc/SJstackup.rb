require 'open-uri'
require 'json'


 base_url = "https://api.stackexchange.com/"
 query_string = '/2.2/questions/no-answers?order=desc&sort=activity&tagged=ruby&site=stackoverflow'

json = open(base_url + query_string).read 

json_data = JSON.parse(json)
all_items = json_data["items"]
all_links = []
all_items.each do |item|
  item.each do  |key, value|
    if key == "link"
      all_links.push(value)
    end
  end
  all_links
end

puts all_links


