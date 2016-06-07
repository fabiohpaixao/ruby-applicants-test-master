class Make < ActiveRecord::Base
	validates :name, uniqueness: true, on: :create
end