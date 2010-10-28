class AdminController < ApplicationController

  before_filter :check_admin

  def index
    @trees = Tree.unhidden
  end

  def new_tree
    @tree = Tree.new
  end
  
  def edit_tree
    @tree = Tree.find(params[:id])
    render :action => 'new_tree'
  end
  
  def update_tree
    if params[:id]
      @tree = Tree.find(params[:id])
      @tree.update_attributes(params[:tree])
    else
      @tree = Tree.create(params[:tree])
      root_question = Question.create({:text => "Sample question. Please edit me.", :tree => @tree})
      @tree.update_attribute(:root_question, root_question)
    end
    if @tree.errors.count > 0 
      flash[:notice] = @tree.errors
      render :action => 'new_tree'
    else
      redirect_to :action => 'index'
    end
  end

  def show_tree
    @tree = Tree.find(params[:id])
    @question = @tree.root_question
  end

  # This does not actually delete the trees. It just hides them.
  def delete_tree
    tree = Tree.find(params[:id])
    tree.update_attribute(:hidden, true)
    flash[:notice] = 
      %Q{You have just deleted the tree called `#{tree.name}'. This is your last chance to undo this.}
    flash[:undo_delete_id] = tree.id
    redirect_to :action => 'index'
  end

  def undo_delete_tree
    tree = Tree.find(params[:id])
    tree.update_attribute(:hidden,false)
    redirect_to :action => 'index'
  end

  # AJAX
  def delete_result
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
    @result   = Result.new(:textile => "", :tree => @response.tree)
    render :edit_result
  end

  def show_question
    @question = Question.find(params[:id])
    render :show_question
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
    @response = Response.find(params[:response_id])
    if params[:commit] == 'Preview'
      if params[:id]
        @result = Result.find(params[:id])
      else
        @result = Result.new
      end
      params[:result].each do |key, value|
        method = "#{key}="
        @result.send(method, value) if @result.respond_to?(method)
      end 
      render :edit_result
    else
      if params[:id]
        @result = Result.find(params[:id])
        @result.update_attributes(params[:result])
      else
        @result = Result.create(params[:result])
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
                       :locals => { :question => q, 
                                    :div_id => "response_#{usec_timestamp}",
                                    :tree => q.tree }
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

  def edit_question
    @question = Question.find(params[:id])
  end

  # AJAX
  def ajax_show_question
    q = Question.find(params[:id])
    render :update do |page|
      page.replace_html question_css_id(q), :partial => 'tree_branch', :locals => { :question => q}
    end
  end

  def update_question
    @question = Question.find(params[:id])
    @question.update_attributes(params[:question])
    render :action => 'show_question'
  end

  # AJAX
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
      page.replace_html response_tree_css_id(r), :partial => 'new_question', 
        :locals => { :response=> r, :tree => r.tree }
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
      page.replace_html response_css_id(r), :partial => 'edit_response', 
        :locals => { :response => r, :tree => r.tree }
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
