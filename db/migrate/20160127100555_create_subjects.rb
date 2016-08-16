class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      
      t.string :dept      #전공세부구분(ex:전공기반, 전공심화, 기초인문사회과학)
      t.string :division  #구분 (전공,교양)
      t.string :code      #학수번호
      t.string :name      #교과목명
      t.string :prof      #교수
      t.text   :time      #학점
      t.string :category  #분류
      t.string :credit    #학점
      t.string :l_time    #시수
      t.string :note00    #비고 0 
      t.string :note01    #비고 1
      t.string :note02    #비고 2 
      t.string :note03    #비고 3
      t.string :note04    #비고 4
      t.integer :count
      t.decimal :avg_score_overall, :precision => 16, :scale => 2
      t.decimal :avg_score_difficulty, :precision => 16, :scale => 2
      t.decimal :avg_score_grade, :precision => 16, :scale => 2
      t.decimal :avg_score_study, :precision => 16, :scale => 2
      t.decimal :avg_score_achievement, :precision => 16, :scale => 2
      t.decimal :avg_score_attendance, :precision => 16, :scale => 2
      

      t.timestamps null: false
    end
  end
end
