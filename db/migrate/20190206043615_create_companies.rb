class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :license_number
      t.datetime :started_at
      t.string :founder_name
      t.string :contact
      t.text :address

      t.timestamps
    end
  end
end
