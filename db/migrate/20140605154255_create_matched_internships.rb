class CreateMatchedInternships < ActiveRecord::Migration
  def change
    create_table :matched_internships do |t|
      t.belongs_to :user
      t.belongs_to :internship
      t.string :response

      t.timestamps
    end
  end
end
