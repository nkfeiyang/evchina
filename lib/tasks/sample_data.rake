require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :demo => :environment do
    Rake::Task['db:migrate'].invoke
    make_categories
    make_users
    make_events  
    make_fav_events
    make_sys_reg_infos
    make_cities
    make_cfg_index_event
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
  
  task :make_fav_events => :environment do    
    make_fav_events       
  end
  
  task :make_sys_reg_infos => :environment do    
    make_sys_reg_infos       
  end
  
  task :make_cities => :environment do
    make_cities
  end
  
  task :make_cfg_index_event => :environment do
    make_cfg_index_event
  end
  
  def make_categories
    Category.create!(:name => "教育培训", :show_order => 1)
    Category.create!(:name => "会议会展", :show_order => 2)
    Category.create!(:name => "生活休闲", :show_order => 3)  # 俱乐部，生活，休闲，体育，户外，旅行
    Category.create!(:name => "网络活动", :show_order => 4)  
    Category.create!(:name => "艺术娱乐", :show_order => 5)  # 演出等
    Category.create!(:name => "其它活动", :show_order => 6) 
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
                            :price => rand(100),
                            :total_tickets => rand(200),
                            :sold_tickets => 0,
                            :status => "published",
                            :email => "test@uxoo.cn",
                            :category_id => rand(6)+1,
                            :city_id => rand(10)+1)
      end
    end
  end
  
  def make_fav_events
    User.all(:limit => 30).each do |user|
      3.times do
        eid = rand(90)+1
        if !user.has_fav_event?(Event.find(eid))    
          user.add_fav_event!(Event.find(eid))
        end
      end
    end
  end
  
  def make_sys_reg_infos
    SysRegInfo.create!(:info_name => '姓名', :desc => '')
    SysRegInfo.create!(:info_name => '性别', :desc => '')
    SysRegInfo.create!(:info_name => '年龄', :desc => '')
    SysRegInfo.create!(:info_name => '邮件', :desc => '')
    SysRegInfo.create!(:info_name => '手机', :desc => '')
    SysRegInfo.create!(:info_name => '座机', :desc => '')
    SysRegInfo.create!(:info_name => '单位', :desc => '')
    SysRegInfo.create!(:info_name => '行业', :desc => '')
    SysRegInfo.create!(:info_name => '职位', :desc => '')   
  end
  
  def make_cities
    City.create!(:ename => 'bj', :name => '北京', :show_order => 1)
    City.create!(:ename => 'sh', :name => '上海', :show_order => 2)
    City.create!(:ename => 'gz', :name => '广州', :show_order => 3)
    City.create!(:ename => 'sz', :name => '深圳', :show_order => 4)
    City.create!(:ename => 'tj', :name => '天津', :show_order => 5)
    City.create!(:ename => 'cd', :name => '成都', :show_order => 6)
    City.create!(:ename => 'hz', :name => '杭州', :show_order => 7)
    City.create!(:ename => 'wuhan', :name => '武汉', :show_order => 8)
    City.create!(:ename => 'xa', :name => '西安', :show_order => 9)
    City.create!(:ename => 'nj', :name => '南京', :show_order => 10)
  end
  
  def make_cfg_index_event
    CfgIndexEvent.create!(:event_id => 1, :show_order => 1,:is_valid => true, :title => '2010迈克学摇滚中国巡演北京演唱会', :desc=>'', :img_url => 'http://pimg.damai.cn/perform/project/202/20299_n1.jpg')
    CfgIndexEvent.create!(:event_id => 2, :show_order => 2,:is_valid => true, :title => '张学友2011巡回演唱会北京站', :desc=>'精美的舞台设计、国际顶尖乐手，价值几千万元的影音器材护航，将歌神完美的音色带给每位歌迷！',:img_url => 'http://pimg.damai.cn/perform/project/174/17454_n1.jpg')
    CfgIndexEvent.create!(:event_id => 3, :show_order => 3,:is_valid => true, :title => '马克西姆钢琴音乐会巡演北京站', :desc=>'四射的激情，澎湃的热力和无处不在的节奏！',:img_url => 'http://pimg.damai.cn/perform/project/210/21001_n1.jpg')
    CfgIndexEvent.create!(:event_id => 4, :show_order => 4,:is_valid => true, :title => '话剧《李小红》', :desc=>'一场灵魂与舞步的共鸣　　一出跳望与生命的对话',:img_url => 'http://pimg.damai.cn/perform/project/201/20191_n1.jpg')
    CfgIndexEvent.create!(:event_id => 5, :show_order => 5,:is_valid => true, :title => '《挡马》《杀庙》《闹天宫》', :desc=>'一场最漂亮的SHOW TIME！罗志祥北京演唱会，敬请期待！',:img_url => 'http://pimg.damai.cn/perform/project/175/17562_n1.jpg')
    CfgIndexEvent.create!(:event_id => 6, :show_order => 6,:is_valid => true, :title => '春晖园温泉门票', :desc=>'在风景宜人的顺义温榆河畔映衬下更显娇媚迷人。',:img_url => 'http://pimg.damai.cn/perform/project/89/8904_n1.jpg')
  end
end






































