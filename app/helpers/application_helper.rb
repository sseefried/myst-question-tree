# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def response_text_css_id(response)
    "response_text_#{response.id}"
  end

  def response_css_id(response)
    "response_#{response.id}"
  end

  def result_css_id(response, result)
    "response_#{response.id}_result_#{result.id}"
  end
  
  def question_css_id(question)
    "question_#{question.id}"
  end

end
