class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.text :name, :null => false
      t.text :textile, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end

