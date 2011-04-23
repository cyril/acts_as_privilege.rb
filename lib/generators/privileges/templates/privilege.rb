class Privilege < ActiveRecord::Base
  attr_accessible :route
  attr_readonly :route

  has_and_belongs_to_many <%=
    model_names.map {|m| m.tableize.to_sym.inspect }.join(', ') %>

  validates_format_of :route, :with => /^[^#]+#[^#]+$/
  validates_uniqueness_of :route, :on => :create
end
