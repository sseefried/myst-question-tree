class Result < ActiveRecord::Base
  
  has_and_belongs_to_many :responses

end
