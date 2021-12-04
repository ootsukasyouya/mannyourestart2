class CahngeNotNullStatus < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :status, false, 0
  end
end
