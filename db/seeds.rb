require 'httparty'
require 'nokogiri'

############ RUNNING CODE #################
def seed_stable_database()
    onet_base_url =  'http://www.onetonline.org/'
    all_attrs = ["Social"]
    #,"Artistic","Enterprising","Conventional","Investigative","Realistic"]
    #Only need to Loop through each one idividually (permutations are included on the 1,2,3 IA (Interest Area))
    all_attrs.each do | a |
      attrcsv = "explore/interests-table/"+ a + '/'+a+".csv?fmt=csv"
      data_table_url = onet_base_url + attrcsv #creating full url
      table = HTTParty.get(data_table_url) #get csv
      rows = table.split(/\r?\n/).map!{|d| d.split(",")} #split by new line and then map each row into array based on , (comma) split
      rows[1..-1].each do |r| ##ADDING CAREERS
       c = Career.create(code:r[0],title:r[1],zone_num:r[-5])
       c.add_interests
       c.add_zone
       c.add_trends
      end
    end
end

#Comment this out if you want to keep the static database but reseed other
##### THIS WILL EFFECTIVELY WIPE THE "STATIC" DATABASE #####
# Career.delete_all
# Interest.delete_all
# ## Create database
# seed_stable_database

### All "normal seeding" should go under this line: ###
u1 = User.create(email:"h55nick@gmail.com",first:"Nick",password:'a',password_confirmation:'a')
u1.interest = Interest.create(social: 26,investigative:35, realistic:26,enterprising:25,conventional:23,artistic:25)

User.delete_all
Question.delete_all
user = User.create( email: 'x', password: 'x', password_confirmation: 'x', first: 'Bryan', last: 'Reid', education: "Bachelor's Degree", location: 'New York, NY', total: 0 )
user.interest = Interest.create( realistic: 0, investigative: 0, social: 0, artistic: 0, conventional: 0, enterprising: 0)

Question.ask('Test the quality of parts before shipment', 'realistic')
Question.ask('Study the structure of the human body', 'investigative')
Question.ask('Conduct a musical choir', 'artistic')
Question.ask('Give career guidance to people', 'social')
Question.ask('Sell restaurant franchises to individuals', 'enterprising')
Question.ask('Generate the monthly payroll checks for an office', 'conventional')


