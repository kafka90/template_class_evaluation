class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      
      t.string   :lecture_id            ##학수번호 
      t.integer  :subject_id            ##과목&평가 연결(Subject DB의 ID저장)
      
      t.string   :lecture_name          ##강의명
      t.string   :lecture_prof          ##교수명 
      
      t.string   :evaluation_writer     ##작성자
      t.integer  :evaluation_writer_id  ##작성자 user id
      t.string   :lecture_semester      ##수강학기
      
      t.integer  :num_test              ##시험횟수
      t.integer  :num_assignment        ##과제횟수
      t.integer  :num_teamproject       ##팀플횟수
      
      t.integer  :score_overall         ##총점
      t.integer  :score_difficulty      ##난이도
      t.integer  :score_grade           ##학점
      t.integer  :score_study           ##학습량
      t.integer  :score_achievement     ##성취감
      t.integer  :score_attendance      ##출석체크
      t.string   :content               ##강의평
      
      t.integer  :report_count,  null:false, default: 0      ##신고당한 횟수 카운트
      
      t.timestamps null: false
    end
  end
end
