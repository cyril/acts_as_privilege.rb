class CreatePrivilegesFor<%= plural_class_name %> < ActiveRecord::Migration
  def self.up
    create_table :abilities do |t|
      t.integer :entity_id, :null => false

      t.string :name, :limit => 255, :null => false
    end

    add_index(:abilities, [:entity_id, :name])

    create_table :entities do |t|
      t.string :name, :limit => 255, :null => false
    end

    add_index(:entities, :name, { :unique => true })

    create_table :<%= ['abilities', plural_name].sort.join('_') %>, :id => false, :force => true do |t|
      t.integer :ability_id, :null => false
      t.integer :<%= "#{singular_name}_id" %>, :null => false
    end
  end

  def self.down
    drop_table :<%= ['abilities', plural_name].sort.join('_') %>
    drop_table :entities
    drop_table :abilities
  end
end
