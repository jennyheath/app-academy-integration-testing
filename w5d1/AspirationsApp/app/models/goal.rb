class Goal < ActiveRecord::Base
  validates :body, :user_id, :visibility, presence: true

  belongs_to :user
end
