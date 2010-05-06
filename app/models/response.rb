class Response < ActiveRecord::Base

  belongs_to :question, :class_name => "Question"
  has_one :child_question, :class_name => "Question"

  has_and_belongs_to_many :results

end
