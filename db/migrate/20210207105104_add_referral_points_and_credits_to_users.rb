class AddReferralPointsAndCreditsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :referral_points, :integer, default: 0
    add_column :users, :credits, :integer, default: 0
  end
end
