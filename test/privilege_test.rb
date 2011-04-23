require 'test_helper'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3', :database => ':memory:')

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :users do |t|
      t.string :login
    end

    create_table :blogs do |t|
      t.references :user, :null => false
      t.string :title
    end

    create_table :categories do |t|
      t.references :blog, :null => false
      t.string :title
    end

    create_table :articles do |t|
      t.references :publishable, :polymorphic => true, :null => false
      t.references :user
      t.string :title
      t.text :content
    end

    create_table :comments do |t|
      t.references :article, :null => false
      t.references :user
      t.text :content
    end

    create_table :privileges do |t|
      t.string :route, :limit => 255, :null => false
    end

    add_index :privileges, :route, {:unique => true}

    create_table :privileges_users, :id => false, :force => true do |t|
      t.integer :privilege_id, :null => false
      t.integer :user_id, :null => false
    end
  end
end

def seed_privileges
  rest_actions = %w(index show new create edit update destroy)
  controllers = {
    :users      => rest_actions,
    :blogs      => rest_actions,
    :categories => rest_actions,
    :articles   => rest_actions,
    :comments   => rest_actions }

  controllers.each_pair do |controller, actions|
    actions.each do |action|
      Privilege.create! :route => [controller, action].join('#')
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class User < ActiveRecord::Base
  acts_as_privilege

  has_one :blog, :dependent => :destroy
  has_many :articles, :dependent => :destroy
  has_many :comments, :dependent => :destroy
end

class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :articles, :as => :publishable, :dependent => :destroy
  has_many :categories, :dependent => :destroy
end

class Category < ActiveRecord::Base
  belongs_to :blog
  has_many :articles, :as => :publishable, :dependent => :destroy
end

class Article < ActiveRecord::Base
  belongs_to :publishable, :polymorphic => true
  belongs_to :user
  has_many :comments, :dependent => :destroy
end

class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
end

class Privilege < ActiveRecord::Base
  attr_accessible :route
  attr_readonly :route

  has_and_belongs_to_many :users

  validates_format_of :route, :with => /^[^#]+#[^#]+$/
  validates_uniqueness_of :route, :on => :create
end

class PrivilegeTest < MiniTest::Unit::TestCase
  def setup
    setup_db

    @admin    = User.create! :login => 'admin'
    @bob      = User.create! :login => 'bob'
    @spammer  = User.create! :login => 'spammer'

    @blog = @admin.create_blog :title => 'my_blog'
    @category = @blog.categories.create! :title => 'main'
    @article = @category.articles.create! :title => 'hello, world',
      :user => @admin
    @comment0 = @article.comments.create! :content => 'foobar',
      :user => @bob
    @comment1 = @article.comments.create! :content => 'spam spam spam',
      :user => @spammer

    seed_privileges

    @admin.update_attribute :privilege_ids, Privilege.all.map(&:id)

    default_privileges = %w(index show).inject([]) do |privileges, action|
      privileges << Privilege.where(['route LIKE ?', "%##{action}"]).map(&:id)
    end

    default_privileges.flatten!

    [@bob, @spammer].each do |user|
      user.update_attribute :privilege_ids, default_privileges
    end

    %w(new create).each do |action|
      @bob.privileges << Privilege.first(:conditions => {
        :route => "comments##{action}" })
    end
  end

  def teardown
    teardown_db
  end

  def test_privileges
    refute @admin.privilege?('silk_routes#index')
    refute @admin.privilege?('silk_routes#show')
    assert @admin.has_privilege?('blogs', 'destroy')
    assert @admin.privilege?('articles#create')
    refute @bob.privilege?('articles#create')
    assert @bob.privilege?(:"comments#create")
    refute @spammer.privilege?('comments#create')
    assert @spammer.privilege?('comments#show')
  end
end
