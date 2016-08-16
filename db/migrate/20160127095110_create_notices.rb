class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|

      t.string :notice_title
      t.string :notice_writer
      t.text   :notice_article
      t.string :notice_password

      t.timestamps null: false
    end
  end
end
