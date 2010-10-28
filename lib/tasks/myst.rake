namespace :myst do
  desc "Reset the admin user's password to the one given"
  task :reset_admin_password, :password, :needs => :environment do |t, args|
    if args[:password]
      u = User.find_by_username('admin')
      u.delete if u
      User.create({:username => 'admin', :password => args[:password], 
                   :password_confirmation => args[:password],
                   :email => 'onlinedamian@gmail.com'})
      puts "Password reset to `#{args[:password]}'"
    else

      puts "Usage: rake #{t.name}[<password>]"
    end
  end


  desc "Upload test data into the database"
  task :test_data => :environment do
    Tree.delete_all
    Question.delete_all
    Response.delete_all
    Result.delete_all

    t = Tree.create({:name => "Test question tree"})

    r1 = Result.create({:name => 'Child & Adolescent Mental Health Service',
                        :textile => "Call: Child & Adolescent Mental Health Service",
                        :tree => t})
    r2 = Result.create({:name => "Mountains Youth Services Team",
                        :textile => "Call: Mountains Youth Services Team",
                        :tree => t})
    r3 = Result.create({:name => "Sydney West Area Health Service",
                        :textile => "Call: Sydney West Area Health Service",
                        :tree => t})
    r4 = Result.create({:name => "Katoomba Community Health Service",
                        :textile => "Call: Katoomba Community Health Service",
                        :tree => t})
    r5 = Result.create({:name => "Nepean Adolescent Drug and Alcohol Intervention Service",
                        :textile => "Call: Nepean Adolescent Drug and Alcohol Intervention Service",
                        :tree => t })

    start = Question.create({:text => "Is the client in immediate risk of self harm or to others?"                    ,
                        :tree => t })


    r_start_1 = Response.create({ :text => "Yes", :question => start, :results => [r1],
                        :tree => t })
    r_start_2 = Response.create({ :text => "No", :question => start,
                        :tree => t })
    
    q1 = Question.create({:text => "What is the Key Presenting Issue", :response => r_start_2                    ,
                        :tree => t})

    r_q1_1 = Response.create({ :text => 'Depression', :question => q1,:tree => t })
    r_q1_2 = Response.create({ :text => 'Self Harm', :question => q1, :tree => t })
    r_q1_3 = Response.create({ :text => 'Anxiety', :question => q1, :tree => t })
    r_q2_4 = Response.create({ :text => 'D&A', :question => q1, :results => [r5], :tree => t})
    
    q2 = Question.create({:text => 'Is the client on medication?',  :response => r_q1_1, :tree => t })
    q3 = Question.create({:text => 'Is the client living at home?', :response => r_q1_2, :tree => t })
    q4 = Question.create({:text => 'Is the client on medication?',  :response => r_q1_3, :tree => t })

    r_q2_1 = Response.create({:text => "Yes", :question => q2, :results => [r3], :tree => t})
    r_q2_2 = Response.create({:text => "No", :question => q2, :results => [r2,r3], :tree => t})
    
    r_q3_1 = Response.create({:text => "Yes", :question => q3, :results => [r3,r4], :tree => t})
    r_q3_2 = Response.create({:text => "No", :question => q3, :results => [r4], :tree => t})

    r_q4_1 = Response.create({:text => "Yes", :question => q4, :results => [r5], :tree => t})
    r_q4_2 = Response.create({:text => "No", :question => q4, :results => [r5], :tree => t})

    t.root_question = start
    t.save

    #####################

    t2 = Tree.create({:name => 'Shapes question tree'})

    triangle      = Result.create({:name => 'Triangle', :textile => "It's a triangle!", :tree => t2})
    quadrilateral = Result.create({:name => 'Quadrilateral', 
                                   :textile => "It's a square looking thing", :tree => t2})

    start2 = Question.create({:text => "How many sides does your shape have?", :tree => t2})

    r_start2_1 = Response.create({ :text => "3", :question => start2, 
                                   :results => [triangle], :tree => t2 })
    r_start2_2 = Response.create({ :text => "4", :question => start2, 
                                   :results => [quadrilateral], :tree => t2 })
    
    t2.root_question = start2
    t2.save
  end
end