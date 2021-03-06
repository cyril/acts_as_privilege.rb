module ActsAsPrivilege
  def privilege?(route)
    privileges.exists?(:route => route.to_s)
  end

  def has_privilege?(controller, action)
    ActiveSupport::Deprecation.warn 'has_privilege?(controller, action) ' +
      'is deprecated and may be removed from future releases, ' +
      'use privilege?(route) instead.'

    privilege? [controller, action].join('#')
  end
end

class ActiveRecord::Base
  def self.acts_as_privilege
    has_and_belongs_to_many :privileges
    attr_accessible :privilege_ids

    include ActsAsPrivilege
  end
end
