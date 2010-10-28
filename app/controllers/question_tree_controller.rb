class QuestionTreeController < ApplicationController

  def index
    @trees = Tree.all
  end

  def show
    tree = if params[:permalink]
      Tree.find_by_permalink(params[:permalink])
    else
      Tree.find(params[:id])
    end
    @question = tree.root_question
    render :action => 'show'
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
