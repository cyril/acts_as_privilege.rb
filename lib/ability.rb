class Ability < ActiveRecord::Base
  # security
  attr_readonly :name, :entity_id

  # relations
  belongs_to :entity
  has_and_belongs_to_many :groups

  # validates
  validates_format_of :name, :with => /^[a-z0-9_]+$/, :allow_nil => false
  validates_uniqueness_of :name, :case_sensitive => false, :scope => :entity_id
end
