class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :education, :email, :first, :last, :lat, :location, :lon, :password, :password_confirmation
  has_one :interest


def get_top_careers(n)
  vals = self.get_top_interests
  c = Career.readonly.joins(:interest).order("#{vals[0]} DESC").order("#{vals[1]} DESC").order("#{vals[2]} DESC").limit(n)
end
def get_top_interests()
  i = self.interest
  k = ["social","investigative","realistic","enterprising","conventional","artistic"]
  v = [i.social,i.investigative,i.realistic,i.enterprising,i.conventional,i.artistic]
  t1 = k[v.index(v.max)]
  t2 = k[v.index(v.sort[-2])]
  t3 = k[v.index(v.sort[-3])]
return [t1,t2,t3]
end

end
