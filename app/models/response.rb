class Response < ActiveRecord::Base

  belongs_to :question, :class_name => "Question"
  has_one :child_question, :class_name => "Question"

  has_and_belongs_to_many :results

#  validate :validate_is_link_or_terminal
  
  def is_link?
    !child_question.nil?
  end

  def is_terminal?
    results.length > 0 
  end

  protected

  def validate_is_link_or_terminal
    errors.add(:child_question, "can't be non-nil if there are results") if is_link? && is_terminal?
    errors.add(:child_question, "can't be nil if there are no results") if !is_link? && !is_terminal?
  end


end
