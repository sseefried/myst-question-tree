# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  MAX_TEXT_LENGTH = 50
  ELLIPSES_LENGTH = 3

  def response_tree_css_id(response)
    "response_tree_#{response.id}"
  end

  def response_css_id(response)
    "response_#{response.id}"
  end

  def result_css_id(response, result)
    "response_#{response.id}_result_#{result.id}"
  end
  
  # This id is used for a div that contains the entire tree
  def question_tree_css_id(question)
    "question_tree_#{question.id}"
  end
  
  # This id is used for a div that just contains the question and links
  def question_css_id(question)
    "question_#{question.id}"
  end

  def question_responses_css_id(question)
    "question_responses_#{question.id}"
  end

  def join_links(texts)
    texts.join(%Q{<span class="tiny-text">|</span>})
  end

  def usec_timestamp
    t = Time.zone.now
    "#{t.to_i}#{t.usec}"
  end

  def result_show_link(result, response)
    link_to "Show", { :action => 'show_result', 
                      :id => result.id, 
                      :response_id => response.id }, {:title => result.name }
  end

  def result_edit_link(result, response)
    link_to "Edit", { :action => 'edit_result', 
                      :id => result.id, 
                      :response_id => response.id }, {:title => result.name }
  end


  def result_delete_link(result, response)
    link_to_remote "Delete", 
      :url => { :action => 'delete_result', 
      :id => response.id, 
      :result_id => result.id }, 
      :confirm => "Are you sure you want to delete this result? Deleting it will remove it from all "+
                  "responses it's currently related to!"
  end
  
  def shorten(text)
    if text.length > MAX_TEXT_LENGTH
    then  "#{text[0..MAX_TEXT_LENGTH-3]}..."
    else text end
  end
  
  def permalink_for(tree)
    "/tree/#{tree.permalink}"
  end

end
