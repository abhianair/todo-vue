class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.text :body
      t.integer :status
      t.bigint :assignee
      t.bigint :reporter

      t.timestamps
    end
  end
end
