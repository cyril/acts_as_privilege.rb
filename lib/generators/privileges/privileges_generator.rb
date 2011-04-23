require 'rails/generators/migration'

class PrivilegesGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)
  argument :model_names, :type => :array

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_model_file
    template 'privilege.rb', 'app/models/privilege.rb'
    template 'privileges_helper.rb', 'app/helpers/privileges_helper.rb'
    migration_template 'create_privileges.rb', 'db/migrate/create_privileges.rb'
  end
end
