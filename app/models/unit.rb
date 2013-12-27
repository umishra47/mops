class Unit < ActiveRecord::Base
  
  def self.create_with_omniauth(auth)
    create! do |unit|
      unit.provider = auth["provider"]
      unit.uid = auth["uid"]
      unit.name = auth["info"]['name']
    end
  end
end
