class AdminController < ApplicationController

  def index
    redirect_to :action => 'list_tree'
  end

  def list_tree
    # FIXME: Show them all
    @question = Question.roots.first
  end
  
  # AJAX
  def delete_result
    resp = Response.find(params[:id])
    results = resp.results
    result_to_delete = Result.find(params[:result_id])
    resp.results = results.select { |res| res.id != result_to_delete.id }
    if resp.results.empty? 
      render :update do |page|
        page.replace_html response_css_id(resp), :partial => 'incomplete_response', :locals => { :response => resp}
      end
    else
      render :update do |page|
        # Just put empty text there
        page.replace_html result_css_id(resp, result_to_delete), :text => ''
      end
    end
  end
  
  # AJAX
  def add_result
  end
  
  # AJAX
  def add_response
    q = Question.find(params[:id])
    render :update do |page| 
      page.insert_html :bottom, question_responses_css_id(q), 
                       :partial => 'new_response', 
                       :locals => { :question => q, :div_id => "response_#{usec_timestamp}" }
    end
  end
  
  def new_response
    r = Response.new(params[:response])
    r[:question_id] = params[:question_id]
    r.save
    render :update do |page|
      page.hide(params[:div_id])
      page.insert_html :bottom, question_responses_css_id(r.question), 
                       :partial => 'response_tree', :locals => { :response => r}
    end
  end
  

  
  # AJAX
  def link_to_question
  end

  # AJAX
  def delete_question
    q = Question.find(params[:id])
    render :update do |page|
      page.replace_html response_css_id(q.response), :partial => 'incomplete_response', :locals => {:response => q.response }
    end
    q.destroy
  end

  #AJAX
  def edit_question
    q = Question.find(params[:id])
    render :update do |page|
      page.replace_html question_css_id(q), :partial => 'edit_question', :locals => { :question => q}
    end
  end
  
  # AJAX 
  def show_question
    q = Question.find(params[:id])
    render :update do |page|
      page.replace_html question_css_id(q), :partial => 'show_question', :locals => { :question => q}
    end
  end

  # AJAX
  def update_question
    q = Question.find(params[:id])
    q.update_attributes(params[:question])
    render :update do |page|
      page.replace_html question_css_id(q), :partial => 'show_question', :locals => { :question => q}
    end
  end
  
  #AJAX
  def link_to_question
  end
  
  #AJAX
  def edit_response
    r = Response.find(params[:id])
    render :update do |page|
      page.replace_html response_css_id(r), :partial => 'edit_response', :locals => { :response => r }
    end
  
  end
  
  # AJAX 
  def show_response
    r = Response.find(params[:id])
    render :update do |page|
      page.replace_html response_css_id(r), :partial => 'show_response', :locals => { :response => r}
    end
  end
  
  # AJAX
  def update_response
    r = Response.find(params[:id])
    r.update_attributes(params[:response])
    render :update do |page|
      page.replace_html response_css_id(r), :partial => 'show_response', :locals => { :response => r}      
    end
  end

end
