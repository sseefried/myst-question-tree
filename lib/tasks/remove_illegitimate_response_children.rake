namespace :myst do
  desc "Removes illegitimate children of a response"
  task :remove_illegitimate_response_children, :needs => :environment do |t, args|
    Response.all.each {|r| r.remove_illegitimate_children }
  end
end