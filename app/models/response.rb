class Response < ActiveRecord::Base

  belongs_to :question, :class_name => "Question"
  has_one :child_question, :class_name => "Question", :dependent => :destroy

  has_and_belongs_to_many :results

  # 
  # A response is either a link, terminal (i.e. it has results) or it is incomplete. Incomplete responses
  # will not appear in the site but they will appear in the admin interface.
  # 
  
  def is_link?
    !child_question.nil?
  end

  def is_terminal?
    results.length > 0 
  end
  
  def is_incomplete?
    results.length == 0 && !is_link? 
  end



end
