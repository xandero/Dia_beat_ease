User.destroy_all

u1 = User.create(:username=> "sox", :dob => "Fri, 30 Mar 1984", :gender => "Female", :weight => 65.0, :height => 130.0, :basal_insulin => 10.0, :bolus_insulin => 1.0, :diabetes_type => "Type 1", :is_admin => "true", :created_at => nil, :updated_at => nil, :password => "chicken", :password_confirmation => "chicken", :email => "sonyacorcoran@gmail.com")

u2 = User.create(:username=> "tom", :dob => "Fri, 30 Mar 1984", :gender => "Male", :weight => 65.0, :height => 150.0, :basal_insulin => 10.0, :bolus_insulin => 1.0, :diabetes_type => "Type 2", :is_admin => "true", :created_at => nil, :updated_at => nil, :password => "chicken", :password_confirmation => "chicken", :email => "tom@tom.com")

u3 = User.create(:username=> "xander", :dob => "Fri, 30 Mar 1984", :gender => "Male", :weight => 65.0, :height => 150.0, :basal_insulin => 10.0, :bolus_insulin => 1.0, :diabetes_type => "Type 2", :is_admin => "true", :created_at => nil, :updated_at => nil, :password => "chicken", :password_confirmation => "chicken", :email => "xander@xander.com")

u4 = User.create(:username=> "bishin", :dob => "Fri, 30 Mar 1984", :gender => "Female", :weight => 65.0, :height => 130.0, :basal_insulin => 10.0, :bolus_insulin => 1.0, :diabetes_type => "Type 1", :is_admin => "true", :created_at => nil, :updated_at => nil, :password => "chicken", :password_confirmation => "chicken", :email => "bishin@bishin.com")

u5 = User.create(:username=> "bob", :dob => "Fri, 30 Mar 1984", :gender => "Male", :weight => 65.0, :height => 130.0, :basal_insulin => 10.0, :bolus_insulin => 1.0, :diabetes_type => "Type 1", :is_admin => "false", :created_at => nil, :updated_at => nil, :password => "chicken", :password_confirmation => "chicken", :email => "bob@bob.com")