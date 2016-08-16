class CreateEvalstatuses < ActiveRecord::Migration
  def change
    create_table :evalstatuses do |t|

      t.integer :article_id
      t.integer :user_id
  
      t.boolean :liked, default: false   #좋아요 했는지 안했는지 체크
      t.boolean :scored, default: false  #평점 매겼는지 안매겼지 체크
      t.boolean :selected, default: false
     
      t.timestamps null: false
    end
  end
end
