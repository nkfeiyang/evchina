class City < ActiveRecord::Base
  has_many :events
  
  def self.GetCityID(ename)
    City.find_by_ename(ename)
  end
end
