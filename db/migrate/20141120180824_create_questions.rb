class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :url
      t.text :body_html
      t.text :body_md

      t.timestamps
    end
  end
end
