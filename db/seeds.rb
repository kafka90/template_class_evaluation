# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'    

Evaluation.create(lecture_id: 'DEFS0EFK', lecture_name: '테스트1', lecture_prof: '테스트', evaluation_writer: '테스트', lecture_semester: '2015년/1학기', score_overall: 10, score_difficulty: 5, score_grade: 3, score_study: 2, score_achievement: 4, score_attendance: 2, content: '강의평가 테스트1') 
Evaluation.create(lecture_id: 'DEFS0EFK', lecture_name: '테스트2', lecture_prof: '테스트', evaluation_writer: '테스트', lecture_semester: '2015년/1학기', score_overall: 10, score_difficulty: 5, score_grade: 3, score_study: 2, score_achievement: 4, score_attendance: 2, content: '강의평가 테스트2') 
Evaluation.create(lecture_id: 'DEFS0EFK', lecture_name: '테스트3', lecture_prof: '테스트', evaluation_writer: '테스트', lecture_semester: '2015년/1학기', score_overall: 10, score_difficulty: 5, score_grade: 3, score_study: 2, score_achievement: 4, score_attendance: 2, content: '강의평가 테스트3') 
Evaluation.create(lecture_id: 'DEFS0EFK', lecture_name: '테스트4', lecture_prof: '테스트', evaluation_writer: '테스트', lecture_semester: '2015년/1학기', score_overall: 10, score_difficulty: 5, score_grade: 3, score_study: 2, score_achievement: 4, score_attendance: 2, content: '강의평가 테스트4') 
Evaluation.create(lecture_id: 'DEFS0EFK', lecture_name: '테스트5', lecture_prof: '테스트', evaluation_writer: '테스트', lecture_semester: '2015년/1학기', score_overall: 10, score_difficulty: 5, score_grade: 3, score_study: 2, score_achievement: 4, score_attendance: 2, content: '강의평가 테스트5') 
Evaluation.create(lecture_id: 'DEFS0EFK', lecture_name: '테스트6', lecture_prof: '테스트', evaluation_writer: '테스트', lecture_semester: '2015년/1학기', score_overall: 10, score_difficulty: 5, score_grade: 3, score_study: 2, score_achievement: 4, score_attendance: 2, content: '강의평가 테스트6') 


CSV.foreach("lecture3.csv", :headers => true, encoding: "euc-kr") do |row|
  Subject.create!(row.to_hash)
end

