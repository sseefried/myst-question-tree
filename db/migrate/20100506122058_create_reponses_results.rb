class CreateReponsesResults < ActiveRecord::Migration
  def self.up
    create_table :responses_results, :id => false do |t|
      t.integer :response_id, :null => false
      t.integer :result_id, :null => false
    end

  end

  def self.down
    drop_table :responses_results
  end
end
