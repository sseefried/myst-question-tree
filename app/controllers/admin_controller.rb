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
#   resp = Response.find(params[:id])
#   results = resp.results
    result_to_delete = Result.find(params[:result_id])


    to_update = []
    Response.all.each do |resp|
      to_update << resp if resp.results.select {|r| r.id == result_to_delete.id }.length > 0
    end

    result_to_delete.destroy

    render :update do |page|
      to_update.each do |resp|
        if resp.results(true).empty?
         page.replace_html response_tree_css_id(resp), :partial => 'incomplete_response',
                                                       :locals => { :response => resp}
        else
         page.replace_html result_css_id(resp, result_to_delete), :text => ''
        end
      end
    end
  end

  # AJAX
  def add_result
    @response = Response.find(params[:id])
    @result   = Result.new(:textile => "")
    render :edit_result
  end

  def show_result
    @result = Result.find(params[:id])
    @response = Response.find(params[:response_id])
  end

  def edit_result
    @result = Result.find(params[:id])
    @response = Response.find(params[:response_id])
  end

  def update_result
    if params[:commit] == 'Preview'
      @response = Response.find(params[:response_id])
      if params[:id]
        @result = Result.find(params[:id])
      else
        @result = Result.new
      end
      @result.textile = params[:result][:textile]
      render :edit_result
    else
      if params[:id]
        @result = Result.find(params[:id])
        @result.update_attributes(params[:result])
      else
        @result = Result.create(params[:result])
        @response = Response.find(params[:response_id])
        @response.results << @result
        @response.save
      end
      render :action => 'show_result'
    end
  end

  def preview
    @textile = params[:textile]
    render :action => 'preview', :layout => false
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
                       :partial => 'response_tree', :locals => { :response => r }
    end
  end

  # AJAX
  def delete_question
    q = Question.find(params[:id])
    render :update do |page|
      page.replace_html response_tree_css_id(q.response), :partial => 'incomplete_response',
        :locals => {:response => q.response }
    end
    q.destroy
  end

  #AJAX
  def edit_question
    q = Question.find(params[:id])
    render :update do |page|
      page.replace_html question_css_id(q), :partial => 'edit_question', :locals => { :question => q }
    end
  end

  # AJAX
  def show_question
    q = Question.find(params[:id])
    render :update do |page|
      page.replace_html question_css_id(q), :partial => 'tree_branch', :locals => { :question => q}
    end
  end


  # AJAX
  def update_question
    q = Question.find(params[:id])
    q.update_attributes(params[:question])
    render :update do |page|
      page.replace_html question_css_id(q), :partial => 'tree_branch', :locals => { :question => q}
    end
  end

  def create_question
    r = Response.find(params[:id])
    q = Question.create(params[:question])
    render :update do |page|
      page.replace_html response_tree_css_id(r), :partial => 'response_tree', :locals => { :response => r }

    end
  end

  #AJAX
  def link_to_question
    r = Response.find(params[:id])
    render :update do |page|
      page.replace_html response_tree_css_id(r), :partial => 'new_question', :locals => { :response=> r }
    end
  end

  #AJAX
  def cancel_link_to_question
    r = Response.find(params[:id])
    render :update do |page|
      page.replace_html response_tree_css_id(r), :partial => 'incomplete_response', :locals => { :response => r}
    end
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

  # AJAX
  def delete_response
    r = Response.find(params[:id])
    render :update do |page|
      page.remove response_tree_css_id(r)
    end
    r.destroy
  end

end
