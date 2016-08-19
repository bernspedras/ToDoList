class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.json :info

      t.timestamps
    end
  end
end