module ActionController
  module Rescue
    protected
    #自定义的错误处理
    def rescue_action_in_public(exception)
      logger.error("rescue_action_in_public executed")
      # 这里就是你可以折腾的地方
      case exception
      when ActiveRecord::RecordNotFound, ::ActionController::RoutingError,
        ::ActionController::UnknownAction
        logger.error("404 displayed")
        render(:file  => "#{RAILS_ROOT}/public/404.html",
               :status   => "404 Not Found")
      else
        logger.error("500 displayed")
        render(:file  => "#{RAILS_ROOT}/public/500.html",
               :status   => "500 Error")
        #      SystemNotifier.deliver_exception_notification(self, request,
        #                                                    exception)
      end
    end
  end
end
