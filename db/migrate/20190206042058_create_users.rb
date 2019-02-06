class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :phone
      t.text :address
      t.integer :salary
      t.integer :bonus
      t.references :company
      t.references :department

      t.timestamps
    end
  end
end
