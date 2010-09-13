require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :demo => :environment do
    Rake::Task['db:reset'].invoke
    make_categories
    make_users
    make_events    
  end
  
  def make_categories
    Category.create!(:name => "教学活动", :show_order => 1)
    Category.create!(:name => "商业会议", :show_order => 2)
    Category.create!(:name => "商务活动", :show_order => 3)
    Category.create!(:name => "网络活动", :show_order => 4)
    Category.create!(:name => "社会事件", :show_order => 5)
    Category.create!(:name => "艺术娱乐", :show_order => 6) 
  end
  
  def make_users
    admin = User.create!(:login => "nkfeiyang",                 
                 :password => "123456",
                 :password_confirmation => "123456")
    admin.toggle!(:admin)
    99.times do |n|
      name = "example#{n+1}"  #Faker::Name.name
      #email = "example-#{n+1}@evchina.cn"
      password = "123456"
      User.create!(:login => name,
                   #:email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
  
  def make_events
    User.all(:limit => 30).each do |user|
      3.times do
        user.events.create!(:title => Faker::Lorem.sentence(4),
                            :content => Faker::Lorem.sentence(15),
                            :start_time => Time.now + user.id*30*60*60,
                            :status => "published",
                            :category_id => rand(5)+1)
      end
    end
  end


end






































