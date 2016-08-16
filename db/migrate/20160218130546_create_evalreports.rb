class CreateEvalreports < ActiveRecord::Migration
  def change
    create_table :evalreports do |t|
      
      t.integer :user_id            #제보유저 id저장
      t.string  :user_name          #제보유저 이름저장
      t.integer :user_report_num 
      
      t.integer :bad_evaluation_id  #불량 강의평가 id저장
      t.string  :report_title       #제보글 제목 저장
      t.string  :report_content     #제보글 내용 저장

      t.timestamps null: false
    end
  end
end
