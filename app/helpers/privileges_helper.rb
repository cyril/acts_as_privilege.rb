module PrivilegesHelper
  def privileges_field(resource)
    render 'acts_as_privilege/fieldset', :resource => resource
  end
end
