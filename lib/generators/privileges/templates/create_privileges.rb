class CreatePrivileges < ActiveRecord::Migration
  def self.up
    create_table :privileges do |t|
      t.string :route, :limit => 255, :null => false
    end

    add_index :privileges, :route, {:unique => true}

    <% model_names.each do |model_name| %>
      create_table <%= ['privileges', model_name.tableize].sort.join('_').to_sym.inspect %>, :id => false, :force => true do |t|
        t.integer :privilege_id, :null => false
        t.integer <%= model_name.classify.foreign_key.to_sym.inspect %>, :null => false
      end
    <% end %>
  end

  def self.down
    <% model_names.each do |model_name| %>
      drop_table <%= ['privileges', model_name.tableize].sort.join('_').to_sym.inspect %>
    <% end %>
    drop_table :privileges
  end
end
