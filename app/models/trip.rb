class Trip < ActiveRecord::Base
  #belongs_to  :created_by, :class_name => "User", :foreign_key => "created_by"
  attr_accessible :created_by, :end_date, :name, :start_date
  belongs_to :user, foreign_key: "created_by"
  
end
