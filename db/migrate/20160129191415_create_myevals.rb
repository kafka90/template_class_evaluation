class CreateMyevals < ActiveRecord::Migration
  def change
    create_table :myevals do |t|
      
      t.integer :user_id            #유저 id저장
      t.string  :user_name          #유저 이름저장
      t.string  :eval_id            #강의평가글 id를 문자열형태로 저장
      
#     serialize :stuff, Array       #평가글 id저장
      
      t.timestamps null: false
    end
  end
end
