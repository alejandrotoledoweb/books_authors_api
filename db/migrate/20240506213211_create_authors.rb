class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.date :birthdate

      t.timestamps
    end
  end
end
