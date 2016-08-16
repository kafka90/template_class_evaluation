class Myeval < ActiveRecord::Base
    belongs_to :user
    serialize :stuff, Array
end
