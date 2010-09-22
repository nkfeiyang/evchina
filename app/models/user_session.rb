class UserSession < Authlogic::Session::Base
  #authlogic默认的login方式是在User model中自动查找login或者是username的字段。
  #但我的目的是想在login的时候屏蔽一些用户，比如虽然用户在User model中存在，
  #但是因为它是一个无效的user，所以不想让它login。因此就必须要在authlogic的login过程中重新设置其查找 User的方法。
  #authlogic默认的查找User model的方法是find_by_login_method，
  #如果不对其进行任何设置，则它会默认调用find_by_smart_case_login_field
  #故要对其默认的查找方法进行更改时，需要进行下面两个地方的改动：

  #  * 在UserSession model中

  #  class UserSession < Authlogic::Session::Base 
  #    find_by_login_method "find_in_effective_users" 
  #  end

  #  * 在User model中
  #  class User < ActiveRecord::Base acts_as_authentic 
  #    def self.find_in_effective_users(login) 
  #      find_by_username_and_effective(login, true) 
  #    end
  #  end

end