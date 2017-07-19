class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :votable, polymorphic: true, index: true
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
