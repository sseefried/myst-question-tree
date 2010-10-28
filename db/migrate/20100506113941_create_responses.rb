# This is a join table
class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.references :question, :null => false
      t.references :tree, :null => false
      t.string :text, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
