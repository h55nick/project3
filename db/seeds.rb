require 'httparty'
##### THIS WILL EFFECTIVELY WIPE THE "STATIC" DATABASE #####
Career.delete_all
Interest.delete_all




# Saving

attrs=[]
all_attrs = ["Social","Artistic","Enterprising","Conventional","Investigative","Realistic"]
url =  'http://www.onetonline.org/'
#Only need to Loop through each one idividually (permutations are included on the 1,2,3 IA (Interest Area))
all_attrs.each do | a |
  attrcsv = "explore/interests-table/"+ a + '/'+a+".csv?fmt=csv"
  data_table_url = url+attrcsv #creating full url
  table = HTTParty.get(data_table_url) #get csv
  rows = table.split(/\r?\n/).map!{|d| d.split(",")} #split by new line and then map each row into array based on , (comma) split
  rows[1..-1].each do |r| ##ADDING CAREERS
   career = Career.create(code:r[0],title:r[1],zone:r[-5])
    intscv = "link/table/details/in/"+ career.code + "/Interests_"+career.code+".csv?fmt=csv&s=OI&t=-10"
    interests = HTTParty.get(url + intscv).split(/\r?\n/).map!{|d| d.split(",")}
    params = {}
    interests[1..-1].map{ |i| params[ i[1].downcase] = i[0] } #creating params for intersts create
    career.interest = Interest.create(params)
    career.save
    binding.pry
  end
end
