class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :text, :null => false
      t.references :response # if NULL then it's a root question
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
