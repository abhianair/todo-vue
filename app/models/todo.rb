class Todo < ApplicationRecord
  after_initialize :init

  belongs_to :user, :class_name => "User", foreign_key: :assignee, optional: true
  belongs_to :ruser, :class_name => "User", foreign_key: :reporter, optional: true


  enum status: [:todo, :done]

  def init
    self.status ||= 0
  end
end
