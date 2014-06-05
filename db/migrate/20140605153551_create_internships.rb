class CreateInternships < ActiveRecord::Migration
  def change
    create_table :internships do |t|
      t.string :title
      t.string :company

      t.timestamps
    end
  end
end
