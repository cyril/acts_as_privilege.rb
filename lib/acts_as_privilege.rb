require 'active_record/base'

module ActsAsPrivilege
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_privilege
      has_and_belongs_to_many :abilities

      class_eval <<-EOV
        include ActsAsPrivilege::InstanceMethods
      EOV
    end
  end

  module InstanceMethods
    def has_privilege?(controller, action)
      self.abilities.each do |ability|
        if ability.name == action
          return true if ability.entity.name == controller
        end
      end
      false
    end
  end
end

ActiveRecord::Base.class_eval { include ActsAsPrivilege }
ActionController::Base.helper PrivilegesHelper
