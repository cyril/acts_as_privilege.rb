class Entity < ActiveRecord::Base
  # security
  attr_readonly :name

  # relations
  has_many :abilities, :dependent => :destroy

  # validates
  validates_format_of :name, :with => /^[a-z0-9_]+$/, :allow_nil => false
  validates_uniqueness_of :name, :case_sensitive => false
end
