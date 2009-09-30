class ActsAsPrivilegeGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.migration_template 'migration.rb', "db/migrate", {:assigns => privileges_local_assigns, :migration_file_name => "create_privileges_for_#{plural_name}"}
    end
  end

  def class_name
    name.camelize
  end

  def plural_name
    custom_name = class_name.underscore.downcase
    custom_name = custom_name.pluralize if ActiveRecord::Base.pluralize_table_names
    custom_name
  end

  def plural_class_name
    plural_name.camelize
  end

  def singular_name
    class_name.underscore.downcase
  end

  private

  def privileges_local_assigns
    returning(assigns = {}) do
      assigns[:class_name] = "create_privileges_for_#{plural_name}"
      assigns[:table_name] = plural_name
    end
  end
end
