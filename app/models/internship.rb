class Internship < ActiveRecord::Base
  has_many :matched_internships
  has_many :users, :through => :matched_internships
end