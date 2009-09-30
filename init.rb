ActiveRecord::Base.send :include, ActiveRecord::Acts::Privilege
ActionController::Base.helper PrivilegesHelper
