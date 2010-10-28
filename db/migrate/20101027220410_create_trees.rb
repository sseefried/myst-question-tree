class CreateTrees < ActiveRecord::Migration
  def self.up
    create_table :trees do |t|
      t.text    :name, :null => false
      t.text    :permalink
      t.boolean :hidden, :null => false, :default => false
      t.integer :root_question_id # Can be null for a while
      t.timestamps
    end
  end

  def self.down
    drop_table :trees
  end
end
