require 'active_record'
require 'pg'

# You may want to add/remove configuration options here
# Using the default 'postgres' database
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'postgres'
)

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.table_exists? 'users'
    create_table :users, force: false do |t|
      t.string :login
    end
  end

  unless ActiveRecord::Base.connection.table_exists? 'posts'
    create_table :posts, force: false do |t|
      t.belongs_to :user
      t.string :title
      t.string :content
      t.string :ip_address
    end
  end

  unless ActiveRecord::Base.connection.table_exists? 'ratings'
    create_table :ratings, force: false do |t|
      t.belongs_to :post
      t.integer :value
    end
  end

  unless ActiveRecord::Base.connection.index_exists? 'posts', 'ip_address'
    add_index :posts, :ip_address
  end
end

class User < ActiveRecord::Base
  has_many :posts

  validates :login, uniqueness: true
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :ratings

  validates :title, presence: true
  validates :content, presence: true
end

class Rating < ActiveRecord::Base
  belongs_to :post
end