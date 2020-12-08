class AddIsProducerToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_producer, :boolean, :default => false
  end
end
