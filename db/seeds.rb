
############ RUNNING CODE #################
def seed_stable_database()
    onet_base_url =  'http://www.onetonline.org/'
    all_attrs = ["Social","Artistic","Enterprising","Conventional","Investigative","Realistic"]
    #Only need to Loop through each one idividually (permutations are included on the 1,2,3 IA (Interest Area))
    all_attrs.each do | a |
      puts "#----------- Now on to " + a + "---------------#"
      attrcsv = "explore/interests-table/"+ a + '/'+a+".csv?fmt=csv"
      data_table_url = onet_base_url + attrcsv #creating full url
      table = HTTParty.get(data_table_url) #get csv
      rows = table.split(/\r?\n/).map!{|d| d.split(",")} #split by new line and then map each row into array based on , (comma) split
      rows[1..-1].each do |r| ##ADDING CAREERS
        puts r[1]
        r.map!{|g| g.gsub(/\"/,'')}
        c = Career.new(code:r[0],title:r[1..[(r.length-6),1].max].join(','),zone_num:r[-5])
          if c.save
            # puts "Added Career- " + Career.all.length.to_s
            puts Career.all[-1].title
             c.add_interests
             c.add_zone
             c.add_trends
             c.add_tasks
          end #This is a property of Career but needs to be pulled from another csv table
      end
    end
end

#Comment this out if you want to keep the static database but reseed other
##### THIS WILL EFFECTIVELY WIPE THE "STATIC" DATABASE #####
  Career.delete_all
  Interest.delete_all
  Zone.delete_all
  Trend.delete_all
# # ## Create database
  seed_stable_database

### All "normal seeding" should go under this line: ###
User.delete_all
Question.delete_all
u1 = User.create(email:"h55nick@gmail.com",first:"Nick",password:'a',password_confirmation:'a')
u1.interest = Interest.create(social: 26,investigative:35, realistic:26,enterprising:25,conventional:23,artistic:25)
user = User.create( email: 'bwreid@gmail.com', password: 'x', password_confirmation: 'x', first: 'Bryan', last: 'Reid', education: "Bachelor's Degree", location: 'New York, NY', total: 0 )
user.interest = Interest.create( realistic: 0, investigative: 0, social: 0, artistic: 0, conventional: 0, enterprising: 0)

Question.ask('Test the quality of parts before shipment', 'realistic')
Question.ask('Study the structure of the human body', 'investigative')
Question.ask('Conduct a musical choir', 'artistic')
Question.ask('Give career guidance to people', 'social')
Question.ask('Sell restaurant franchises to individuals', 'enterprising')
Question.ask('Generate the monthly payroll checks for an office', 'conventional')
Question.ask('Lay brick or tile', 'realistic')
Question.ask('Study animal behavior', 'investigative')
Question.ask('Direct a play', 'artistic')
Question.ask('Do volunteer work at a non-profit organization', 'social')
Question.ask('Sell merchandise at a department store', 'enterprising')
Question.ask('Inventory supplies using a hand-held computer', 'conventional')
Question.ask('Work on an offshore oil-drilling rig', 'realistic')
Question.ask('Do research on plants or animals', 'investigative')
Question.ask('Design artwork for magazines', 'artistic')
Question.ask('Help people who have problems with drugs or alcohol', 'social')
Question.ask('Manage the operations of a hotel', 'enterprising')
Question.ask('Use a computer program to generate customer bills', 'conventional')
Question.ask('Assemble electronic parts', 'realistic')
Question.ask('Develop a new medical treatment or procedure', 'investigative')
Question.ask('Write a song', 'artistic')
Question.ask('Teach an individual an exercise routine', 'social')
Question.ask('Operate a beauty salon or barber shop', 'enterprising')
Question.ask('Maintain employee records', 'conventional')
Question.ask('Operate a grinding machine in a factory', 'realistic')
Question.ask('Conduct biological research', 'investigative')
Question.ask('Write books or plays', 'artistic')
Question.ask('Help people with family-related problems', 'social')
Question.ask('Manage a department within a large company', 'enterprising')
Question.ask('Compute and record statistical and other numerical data', 'conventional')
Question.ask('Fix a broken faucet', 'realistic')
Question.ask('Study whales and other types of marine life', 'investigative')
Question.ask('Play a musical instrument', 'artistic')
Question.ask('Supervise the activities of children at a camp', 'social')
Question.ask('Manage a clothing store', 'enterprising')
Question.ask('Operate a calculator', 'conventional')
Question.ask('Assemble products in a factory', 'realistic')
Question.ask('Work in a biology lab', 'investigative')
Question.ask('Perform stunts for a movie or television show', 'artistic')
Question.ask('Teach children how to read', 'social')
Question.ask('Sell houses', 'enterprising')
Question.ask('Handle customers bank transactions', 'conventional')
Question.ask('Install flooring in houses', 'realistic')
Question.ask('Make a map of the bottom of an ocean', 'investigative')
Question.ask('Design sets for plays', 'artistic')
Question.ask('Help elderly people with their daily activities', 'social')
Question.ask('Run a toy store', 'enterprising')
Question.ask('Keep shipping and receiving records', 'conventional')
