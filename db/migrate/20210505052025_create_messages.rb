class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :phone_number
      t.string :from_name
      t.string :to_name
      t.text :message

      t.timestamps
    end
  end
end
