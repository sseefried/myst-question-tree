class Response < ActiveRecord::Base

  belongs_to :tree
  belongs_to :question, :class_name => "Question"
  has_one :child_question, :class_name => "Question", :dependent => :destroy

  #
  # A Response *should* only have one child. However a bug (2011-10-11--11-41) meant that
  # some times more than one child was being created for a response. In order to find these
  # and remove them we added this association.
  # 
  # A rake task, rake :remove_illegitimate_response_children removes them
  #
  has_many :illegitimate_children, :class_name => "Question"

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


  #
  # Only to be used as a bug fix. Do not use for any other purpose.
  #
  def remove_illegitimate_children
    puts "Destroying illegitimate children of response #{id}: #{text}" if illegitimate_children.length > 1
    illegitimate_children.select {|q| q != child_question }.each do |q|
      puts "  Destroying illegitimate child question #{q.id}: #{q.text}"
      q.destroy
    end
  end


end
