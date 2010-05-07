class QuestionTreeController < ApplicationController

  def index
    id = params[:id] ? params[:id].to_i : Question.roots.first
    @question = Question.find(id)
  end

  def next
    resp = Response.find(params[:response_id])
    if !resp.child_question.nil?
      @question = resp.child_question
    else
      @results = resp.results
    end
    render :action => 'index'
  end

  def show_tree
    @tree = Question.find(params[:id]).as_tree
  end

end
