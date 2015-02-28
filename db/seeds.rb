User.destroy_all
Activity.destroy_all

u1 = User.create(:username=> "sox", :dob => "Fri, 30 Mar 1984", :gender => "Female", :weight => 65.0, :height => 130.0, :basal_insulin => 10.0, :bolus_insulin => 1.0, :diabetes_type => "Type 1", :is_admin => "true", :created_at => nil, :updated_at => nil, :password => "chicken", :password_confirmation => "chicken", :email => "sox@sox.com")

# u2 = User.create(:username => "tom", :dob => nil, :gender => "male", :weight => 65, :height => 150, :basal_insulin => 15, :bolus_insulin => 1, :diabetes_type => "Type 1", :is_admin => "TRUE", :created_at => nil, :updated_at => nil, :password_digest => "chicken", :email => "tom@tom.com")

# u3 = User.create(:username => "bishin", :dob => nil, :gender => "female", :weight => 65, :height => 130, :basal_insulin => 10, :bolus_insulin => 1, :diabetes_type => "Type 1", :is_admin => "TRUE", :created_at => nil, :updated_at => nil, :password_digest => "chicken", :email => "bishin@bish.com"),

# u4 = User.create(:username => "xander", :dob => nil, :gender => "male", :weight => 65, :height => 150, :basal_insulin => 15, :bolus_insulin => 1, :diabetes_type => "Type 1", :is_admin => "TRUE", :created_at => nil, :updated_at => nil, :password_digest => "chicken", :email => "xander@xander.com"),

# a1 = Activity.create(:activityname =>"jog", :duration =>60, :intensity =>4, :activity_time =>nil, :created_at =>nil, :updated_at =>nil, :user_id =>nil)