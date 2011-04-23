module PrivilegesHelper
  def privileges_field(f)
    render 'acts_as_privilege/fieldset', :f => f
  end
end
