# 本表的用途：当用户想要参加一个活动时，它必须提交哪些信息，
# 这里保存基本信息，发布者发布事件时可以从这个表来选择他需要的信息。
# 目前暂不考虑发布者要求自定义收集信息的功能。
# 目前只让用户输入所有的信息，不提供选择等功能。这样对发布者而言，它收到的信息可能有误。比如无法规定用户输入的值。
class CreateSysRegInfos < ActiveRecord::Migration
  def self.up
    create_table :sys_reg_infos do |t|
      t.string :info_name     # 待收集的名称，比如用户名，手机号等等。
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sys_reg_infos
  end
end
