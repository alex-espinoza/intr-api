class MatchedInternship < ActiveRecord::Base
  belongs_to :user
  belongs_to :internship

  state_machine :response, :initial => :no_response do
    event :mark_as_interested do
      transition :no_response => :interested
    end

    event :mark_as_not_interested do
      transition :no_response => :not_interested
    end
  end
end