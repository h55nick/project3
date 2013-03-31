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
        r.map!{|g| g.gsub(/\"/,'')}
       c = Career.create(code:r[0],title:r[1..[(r.length-6),1].max].join(','),zone_num:r[-5])
       c.add_interests
       c.add_zone
       c.add_trends
       c.add_tasks #This is a property of Career but needs to be pulled from another csv table
        if Career.all.length == 30
          binding.pry
          # return
        end
      end
    end
end

#Comment this out if you want to keep the static database but reseed other
##### THIS WILL EFFECTIVELY WIPE THE "STATIC" DATABASE #####
 Career.delete_all
 Interest.delete_all
 Zone.delete_all
 Trend.delete_all
# ## Create database
 seed_stable_database

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

###------- NEW QUESTIONS WITH NO INTEREST ATTACHED----#####
Question.ask('Lay brick or tile',x)
Question.ask('Study animal behavior',x)
Question.ask('Direct a play',x)
Question.ask('Do volunteer work at a non-profit organization',x)
Question.ask('Sell merchandise at a department store',x)
Question.ask('Inventory supplies using a hand-held computer',x)
Question.ask('Work on an offshore oil-drilling rig',x)
Question.ask('Do research on plants or animals',x)
Question.ask('Design artwork for magazines',x)
Question.ask('Help people who have problems with drugs or alcohol',x)
Question.ask('Manage the operations of a hotel',x)
Question.ask('Use a computer program to generate customer bills',x)
Question.ask('Assemble electronic parts',x)
Question.ask('Develop a new medical treatment or procedure',x)
Question.ask('Write a song',x)
Question.ask('Teach an individual an exercise routine',x)
Question.ask('Operate a beauty salon or barber shop',x)
Question.ask('Maintain employee records',x)
Question.ask('Operate a grinding machine in a factory',x)
Question.ask('Conduct biological research',x)
Question.ask('Write books or plays',x)
Question.ask('Help people with family-related problems',x)
Question.ask('Manage a department within a large company',x)
Question.ask('Compute and record statistical and other numerical data',x)
Question.ask('Fix a broken faucet',x)
Question.ask('Study whales and other types of marine life',x)
Question.ask('Play a musical instrument',x)
Question.ask('Supervise the activities of children at a camp',x)
Question.ask('Manage a clothing store',x)
Question.ask('Operate a calculator',x)
Question.ask('Assemble products in a factory',x)
Question.ask('Work in a biology lab',x)
Question.ask('Perform stunts for a movie or television show',x)
Question.ask('Teach children how to read',x)
Question.ask('Sell houses',x)
Question.ask('Handle customers bank transactions',x)
Question.ask('Install flooring in houses',x)
Question.ask('Make a map of the bottom of an ocean',x)
Question.ask('Design sets for plays',x)
Question.ask('Help elderly people with their daily activities',x)
Question.ask('Run a toy store',x)
Question.ask('Keep shipping and receiving records',x)



