class Evalstatus < ActiveRecord::Base
    belongs_to :user
    belongs_to :subject
end
