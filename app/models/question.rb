class Question < ActiveRecord::Base
  belongs_to :response # Could be +nil+
  has_many :responses

  named_scope :roots,  { :conditions => { :response_id => nil}}
  
  def is_root?
    response.nil?
  end

  def as_tree
    t = {}
    self.responses.each do |resp|
      t[resp.text] = resp.child_question.as_tree  if resp.is_link?
      t[resp.text] = resp.results.collect { |res| res.id } if resp.is_terminal?
      # We do not put in incomplete ones
    end
    { :question => self.text, :responses => t }
  end
end
