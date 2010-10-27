namespace :myst do
  desc "Upload test data into the database"
  task :test_data => :environment do
    Question.delete_all
    Response.delete_all
    Result.delete_all

    r1 = Result.create({:name => 'Child & Adolescent Mental Health Service',
                        :textile => "Call: Child & Adolescent Mental Health Service"})
    r2 = Result.create({:name => "Mountains Youth Services Team",
                        :textile => "Call: Mountains Youth Services Team"})
    r3 = Result.create({:name => "Sydney West Area Health Service",
                        :textile => "Call: Sydney West Area Health Service"})
    r4 = Result.create({:name => "Katoomba Community Health Service",
                        :textile => "Call: Katoomba Community Health Service"})
    r5 = Result.create({:name => "Nepean Adolescent Drug and Alcohol Intervention Service",
                        :textile => "Call: Nepean Adolescent Drug and Alcohol Intervention Service" })

    start = Question.create({:text => "Is the client in immediate risk of self harm or to others?" })

    r_start_1 = Response.create({ :text => "Yes", :question => start, :results => [r1] })
    r_start_2 = Response.create({ :text => "No", :question => start })
    
    q1 = Question.create({:text => "What is the Key Presenting Issue", :response => r_start_2})

    r_q1_1 = Response.create({ :text => 'Depression', :question => q1 })
    r_q1_2 = Response.create({ :text => 'Self Harm', :question => q1 })
    r_q1_3 = Response.create({ :text => 'Anxiety', :question => q1 })
    r_q2_4 = Response.create({ :text => 'D&A', :question => q1, :results => [r5]})
    
    q2 = Question.create({:text => 'Is the client on medication?',  :response => r_q1_1 })
    q3 = Question.create({:text => 'Is the client living at home?', :response => r_q1_2 })
    q4 = Question.create({:text => 'Is the client on medication?',  :response => r_q1_3 })

    r_q2_1 = Response.create({:text => "Yes", :question => q2, :results => [r3]})
    r_q2_2 = Response.create({:text => "No", :question => q2, :results => [r2,r3]})
    
    r_q3_1 = Response.create({:text => "Yes", :question => q3, :results => [r3,r4]})
    r_q3_2 = Response.create({:text => "No", :question => q3, :results => [r4]})

    r_q4_1 = Response.create({:text => "Yes", :question => q4, :results => [r5]})
    r_q4_2 = Response.create({:text => "No", :question => q4, :results => [r5]})
  end
end