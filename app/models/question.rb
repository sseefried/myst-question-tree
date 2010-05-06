class Question < ActiveRecord::Base
  belongs_to :response # Could be +nil+
  has_many :responses

  named_scope :roots,  { :conditions => { :response_id => nil}}

  def is_root?
    response.nil?
  end

end
