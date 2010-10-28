class Result < ActiveRecord::Base
  
  belongs_to :tree
  has_and_belongs_to_many :responses
  validates_presence_of :textile, :name

end
