class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :locale, :string
    add_column :users, :gender, :string
    add_column :users, :enable, :boolean, :default => true
  end
end
