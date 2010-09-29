require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :demo => :environment do
    Rake::Task['db:migrate'].invoke
    make_categories
    make_users
    make_events    
  end
  
  task :make_categories => :environment do    
    make_categories       
  end
  task :make_users => :environment do    
    make_users       
  end
  task :make_events => :environment do    
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
                 :email => "wang_haibing@126.com",
                 :password => "123456",
                 :password_confirmation => "123456")
    admin.toggle!(:admin)
    99.times do |n|
      name = "example#{n+1}"  #Faker::Name.name
      email = "ea-#{n+1}@evchina.cn"
      password = "123456"
      User.create!(:login => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
  
  def make_events
    User.all(:limit => 30).each do |user|
      3.times do
        t = (rand(30)+1)*24*60*60
        user.events.create!(:title => Faker::Lorem.sentence(4),
                            :intro => Faker::Lorem.sentence(30),
                            :content => Faker::Lorem.sentence(150),
                            :start_time => Time.now.beginning_of_day + 9*60*60 + t, 
                            :end_time => Time.now.beginning_of_day + 9*60*60 + t + rand(24)*60*60,
                            :address => 'Haidian, Beijing',
                            :views => 0,
                            :score => rand(6),
                            :total_tickets => rand(200),
                            :sold_tickets => 0,
                            :status => "published",
                            :email => "test@uxoo.cn",
                            :category_id => rand(6)+1)
      end
    end
  end


end






































