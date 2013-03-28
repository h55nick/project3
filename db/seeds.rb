require 'httparty'
require 'nokogiri'
##### THIS WILL EFFECTIVELY WIPE THE "STATIC" DATABASE #####
#Career.delete_all
#Interest.delete_all


############ RUNNING CODE #################
def seed_database()
    onet_base_url =  'http://www.onetonline.org/'
    all_attrs = ["Social","Artistic","Enterprising","Conventional","Investigative","Realistic"]
    #Only need to Loop through each one idividually (permutations are included on the 1,2,3 IA (Interest Area))
    all_attrs.each do | a |
      attrcsv = "explore/interests-table/"+ a + '/'+a+".csv?fmt=csv"
      data_table_url = onet_base_url + attrcsv #creating full url
      table = HTTParty.get(data_table_url) #get csv
      rows = table.split(/\r?\n/).map!{|d| d.split(",")} #split by new line and then map each row into array based on , (comma) split
      rows[1..-1].each do |r| ##ADDING CAREERS
       c = Career.create(code:r[0],title:r[1],zone:r[-5])
       c.add_interests
       c.add_zone
       c.add_trends
      end
    end
end



## Create database
seed_database



