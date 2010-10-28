class SysRegInfo < ActiveRecord::Base
  has_many :event_reg_requires

    def self.list_options
    find(:all, :select=>"id, info_name").collect{|p| [p.info_name, p.id]}
  end
end
