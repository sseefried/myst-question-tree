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

end
