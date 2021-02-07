class AddReferrerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :referrer, index: true
  end
end
