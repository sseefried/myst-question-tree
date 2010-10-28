class QuestionTreeController < ApplicationController

  def index
    @trees = Tree.unhidden
  end

  def show
    tree = if params[:permalink]
      Tree.find_by_permalink(params[:permalink])
    else
      Tree.find(params[:id])
    end
    @question = tree.root_question
    if @question && !tree.hidden
      render :action => 'show'
    else
      render :action => 'not_found'
    end
  end


  def next
    resp = Response.find(params[:response_id])
    if !resp.child_question.nil?
      @question = resp.child_question
    else
      @results = resp.results
    end
    render :action => 'show'
  end

end
