class User < TaskManager

  # devise :cas_authenticatable
  has_many :todos, :class_name => "Todo", foreign_key: :assignee
  has_many :reported_todos, :class_name => "Todo", foreign_key: :reporter

end
