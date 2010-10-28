class Tree < ActiveRecord::Base

  MAX_PERMALINK_LENGTH = 60 # characters

  belongs_to :root_question, :class_name => 'Question'
  before_save :set_permalink
  
  validates_uniqueness_of :name
  
  def self.unhidden
    self.find(:all, :conditions => ['hidden = ?', false])
  end

  def set_permalink
    self.permalink = words_for_permalink.join("-")
  end
  
  private
  
  def words_for_permalink
    all_words, words = self.name.downcase.split.collect {|w| URI.escape(w)}, []
    len = 0
    all_words.each do |word|
      words << word
      len += word.length
      break if len > MAX_PERMALINK_LENGTH
    end
    words
  end

end
