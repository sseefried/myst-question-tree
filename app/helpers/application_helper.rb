# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

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

end
