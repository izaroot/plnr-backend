class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :profile_img
      t.datetime :birthdate
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
