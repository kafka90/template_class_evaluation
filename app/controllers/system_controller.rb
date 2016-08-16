class SystemController < ApplicationController
    include ApplicationHelper
    require 'digest/md5' 
    
    def lecture_evaluate
        if user_signed_in?
            @subject_name = params[:id]
        else
            redirect_to '/users/sign_in'
        end
    end
    
    def lecture_evaluate_process
        @evaluation_writer = current_user.name + '(' + current_user.std_num_secret + ')'
        @auto_complete_name = params[:lecture_name]
        @lecture_name = @auto_complete_name.split('-')[0]
        @lecture_prof = @auto_complete_name.split('-')[1]
        
        @when = params[:lecture_semester]
        @year = @when[0..3]
        @semester = @when[4]
        @eval = Evaluation.where(subject_id: params[:subject_id])
        @eval_check = @eval.where(evaluation_writer_id: current_user.id)
        
    	if @eval_check.count != 0 
    	    @fail = 1
    	else
    	    @new_evaluation = Evaluation.new
            @new_evaluation.subject_id = params[:subject_id]
            @new_evaluation.lecture_name = @lecture_name
            @new_evaluation.lecture_prof = @lecture_prof
            @new_evaluation.evaluation_writer = @evaluation_writer
            @new_evaluation.evaluation_writer_id = current_user.id
            @new_evaluation.lecture_semester = @year + '년/' + @semester + '학기'
            @new_evaluation.num_test = params[:num_test]
            @new_evaluation.num_assignment = params[:num_assignment] 
            @new_evaluation.num_teamproject = params[:num_teamproject]
            @new_evaluation.score_overall = params[:score_overall]
            @new_evaluation.score_difficulty = params[:score_difficulty]
            @new_evaluation.score_grade = params[:score_grade]
            @new_evaluation.score_study = params[:score_study]
            @new_evaluation.score_achievement = params[:score_achievement]
            @new_evaluation.score_attendance = params[:score_attendance]
            @new_evaluation.content = params[:content]
            @new_evaluation.save
            
            @evaluations = Evaluation.where(:subject_id => params[:subject_id])
            @evaluations_amount = @evaluations.count
            sum_score_overall = 0
            sum_score_difficulty= 0
            sum_score_grade= 0
            sum_score_study= 0
            sum_score_achievement= 0
            sum_score_attendance= 0
           
            @evaluations.each do |x|
                sum_score_overall += x.score_overall
                sum_score_difficulty += x.score_difficulty
                sum_score_grade += x.score_grade
                sum_score_study += x.score_study
                sum_score_achievement += x.score_achievement
                sum_score_attendance += x.score_attendance
            end
           
            avg_score_overall = sum_score_overall.to_d/@evaluations_amount.to_d
            avg_score_difficulty = sum_score_difficulty.to_d/@evaluations_amount.to_d
            avg_score_grade = sum_score_grade.to_d/@evaluations_amount.to_d
            avg_score_study = sum_score_study.to_d/@evaluations_amount.to_d
            avg_score_achievement = sum_score_achievement.to_d/@evaluations_amount.to_d
            avg_score_attendance = sum_score_attendance.to_d/@evaluations_amount.to_d
           
            @revised_subject = Subject.where(:id => params[:subject_id]).take
            @revised_subject.count = @evaluations_amount
            @revised_subject.avg_score_overall = avg_score_overall.to_d
            @revised_subject.avg_score_difficulty = avg_score_difficulty.to_d
            @revised_subject.avg_score_grade = avg_score_grade.to_d
            @revised_subject.avg_score_study = avg_score_study.to_d
            @revised_subject.avg_score_achievement = avg_score_achievement.to_d
            @revised_subject.avg_score_attendance = avg_score_attendance.to_d
            @revised_subject.save
            
            list_up = current_user.list_myeval + @new_evaluation.id.to_s + '/'
            count_up = current_user.num_myeval + 1
            count_up_overall = current_user.overall_num_myeval + 1
            current_user.update_attribute(:list_myeval, list_up)
            current_user.update_attribute(:num_myeval, count_up)
            current_user.update_attribute(:overall_num_myeval, count_up_overall)
            redirect_to '/main/main'
        end  
    end
    
    def send_report
        @this_evaluation = params[:id]
        @user_report_list = Evalreport.where(:user_id => current_user.id)  
        @repetition_check = Evalreport.where(user_id: current_user.id, bad_evaluation_id: @this_evaluation)

        if( current_user.authentication == 0 or current_user.authentication == 1 )
            @flag = 1
        elsif( current_user.num_myeval < 3 )
            @flag = 2
        elsif( @repetition_check.count != 0 )
            @flag = 3
        else
            @flag = 0
        end
    end
    
    def send_report_detail
        @this_report = Evalreport.find(params[:id])
    end
    
    def send_report_mail
        @user_name = current_user.name
        @user_mail = current_user.email 
        @report_id = params[:r_id]
        @report_title = params[:r_title]
        @report_content = params[:r_content]
        
        @this_evaluation = Evaluation.find(@report_id)
        @count_up_eval = @this_evaluation.report_count + 1 
        @count_up_user = current_user.num_myreport + 1
        @this_evaluation.update_attribute(:report_count, @count_up_eval)
        current_user.update_attribute(:num_myreport, @count_up_user)
        
        @new_report = Evalreport.new
        @new_report.user_id = current_user.id
        @new_report.user_name = current_user.name
        @new_report.user_report_num = current_user.num_myreport
        @new_report.bad_evaluation_id = @report_id
        @new_report.report_title = @report_title
        @new_report.report_content = @report_content
        @new_report.save
        
        Report.report_email(@user_name, @user_mail, @report_title, @report_content, @report_id).deliver_now
        
        route = '/system/send_report/' + @report_id.to_s
        redirect_to route   
    end
    
    def authenticate
        if user_signed_in?
            @code = Digest::MD5.hexdigest(current_user.i_d)
            @sending_code = @code.slice(1..8)
            @user_mail = current_user.i_d + "@skku.edu"
            current_user.update_attribute(:confirm_code, @sending_code)
            current_user.update_attribute(:email, @user_mail)
        else
            redirect_to '/users/sign_in'
        end
    end 
      
    def test_confirm
        @kkkk = params[:rrr]
        if( @kkkk == current_user.confirm_code )
            current_user.update_attribute(:authentication, 2)
            current_user.update_attribute(:token1, "e1216ce35d8780f2aa86118aa7de9223")
            redirect_to '/main/main'  
        else
            current_user.update_attribute(:authentication, 1) 
            redirect_to '/system/authenticate'  
        end
    end

    def send_mail
        @user_mail = current_user.email
        @confirm_code = current_user.confirm_code
        Confirm.confirm_email(@user_mail, @confirm_code).deliver_now
        redirect_to '/system/authenticate'   
    end 
        
    def contact
        unless user_signed_in?
            redirect_to '/users/sign_in'
        end
        @user_report_list = Evalreport.where(user_id: current_user.id) 
    end
    
    def send_contact_mail
        @user_name = params[:c_user]
        @user_mail = params[:c_mail]
        @contact_title = params[:c_title]
        @contact_content = params[:c_content]
        @count_up_user = current_user.num_myreport + 1
        current_user.update_attribute(:num_myreport, @count_up_user)

        @new_report = Evalreport.new
        @new_report.user_id = current_user.id
        @new_report.user_name = current_user.name
        @new_report.user_report_num = current_user.num_myreport
        @new_report.report_title = '[문의] ' + @contact_title
        @new_report.report_content = @contact_content
        @new_report.save
        
        Contact.contact_email(@user_name, @user_mail, @contact_title, @contact_content).deliver_now
        redirect_to '/system/contact'  
    end
            
    def myinfo_eval
        if user_signed_in?
            @find_evaluation = Evaluation.all
            @store_myeval = Array.new
            0.upto(current_user.num_myeval - 1) do |x|
                @store_myeval << current_user.list_myeval.split('/')[x].to_i
            end
        else
            redirect_to '/users/sign_in'
        end
    end 
        
    def myinfo_eval_modify
        if user_signed_in?
            @this_evaluation = Evaluation.find(params[:id])
            @this_id = params[:id]
        else
            redirect_to '/users/sign_in'
        end
    end
    
    def myinfo_eval_modify_process 
        @evalutaion_modify = Evaluation.where(:id => params[:id]).take
#       @evalutaion_modify.lecture_semester = params[:lecture_semester]
        @evalutaion_modify.score_overall = params[:score_overall]
        @evalutaion_modify.score_difficulty = params[:score_difficulty]
        @evalutaion_modify.score_grade = params[:score_grade]
        @evalutaion_modify.score_study = params[:score_study]
        @evalutaion_modify.score_achievement = params[:score_achievement]
        @evalutaion_modify.score_attendance = params[:score_attendance]
        @evalutaion_modify.content = params[:content]
        @evalutaion_modify.save
        
        redirect_to '/system/myinfo_eval'
    end
    
    def myinfo_modify
        unless user_signed_in?
            redirect_to '/users/sign_in'
        end
    end
    
    def myinfo_modify_process
        @modify_username = params[:modify_username]
        @myeval = Evaluation.where(evaluation_writer_id: current_user.id)        
        @modify_username_complete = @modify_username + '(' + current_user.std_num_secret + ')'
        @myeval.each do |x|
            x.update_attribute(:evaluation_writer, @modify_username_complete)
        end
        current_user.update_attribute(:name, @modify_username) 
        
        redirect_to '/main/main'
    end 
    
    def search
        respond_to do |format|
          format.html
          format.json { @subjects = Subject.search(params[:term]) }
        end
    end
    
    def finding_test_result
        @term = params[:searching]
        @current_page = params[:current_page]
        @current_page2 = @current_page.to_i
        @totalresult = Subject.search2(params[:searching]).count           
        @totalpagelist = getTotalPageList(@totalresult, 10)
        @results = Subject.search2(params[:searching]).limit(10).offset((@current_page2-1)*10)
        @result_amount = @results.count
        @result_count = 0
        @store_list_myeval = Array.new
        
        0.upto(current_user.num_myeval - 1) do |x|
            @store_list_myeval << current_user.list_myeval.split('/')[x].to_i
        end  
        
        if @current_page == nil
            @current_page3 = 1
        elsif @current_page2 % 10 == 1
            @current_page3 = @current_page2
        elsif @current_page2 % 10 == 0
            @current_page3 = @current_page2 - 9
        else
            @current_page3 = @current_page2 - (@current_page2 % 10 - 1)
        end 
    end
    
    def finding_test_result2
        @recent_notice = Notice.last 
        if params[:dept] != nil
            @dept = params[:dept]
            @division = params[:division]
            @name = params[:name]     
        else
            params[:dept] = "교양"
            params[:division] = "인성"
            params[:name] = "전체"
            @dept = params[:dept]
            @division = params[:division]
            @name = params[:name]  
        end
       
        if params[:current_page] == nil
            @current_page = 1
        else
            @current_page = params[:current_page]
        end
       
        @current_page2 = @current_page.to_i
        @totalresult = Subject.search3(params[:dept], params[:division], params[:name]).count           
        @totalpagelist = getTotalPageList(@totalresult, 10)
        @ori_results = Subject.search3(params[:dept], params[:division], params[:name])
        @ori_results_order_overall = @ori_results.sort_by(&:avg_score_overall).reverse
        @ori_results_order_difficulty = @ori_results.sort_by(&:avg_score_difficulty).reverse
        @ori_results_order_grade = @ori_results.sort_by(&:avg_score_grade).reverse
        @ori_results_order_study = @ori_results.sort_by(&:avg_score_study).reverse
        @ori_results_order_achievement = @ori_results.sort_by(&:avg_score_achievement).reverse
        @ori_results_order_attendance = @ori_results.sort_by(&:avg_score_attendance).reverse
        
        @results_overall = @ori_results_order_overall[(@current_page2-1)*10..((@current_page2-1)*10)+9]
        @results_difficulty= @ori_results_order_difficulty[(@current_page2-1)*10..((@current_page2-1)*10)+9]
        @results_grade= @ori_results_order_grade[(@current_page2-1)*10..((@current_page2-1)*10)+9]
        @results_study= @ori_results_order_study[(@current_page2-1)*10..((@current_page2-1)*10)+9]
        @results_achievement= @ori_results_order_achievement[(@current_page2-1)*10..((@current_page2-1)*10)+9]
        @results_attendance= @ori_results_order_attendance[(@current_page2-1)*10..((@current_page2-1)*10)+9]
        @result_amount = @results_overall.count
        @result_count = 0
        @store_list_myeval = Array.new
        0.upto(current_user.num_myeval - 1) do |x|
        @store_list_myeval << current_user.list_myeval.split('/')[x].to_i
        end  
        if @current_page == nil
         @current_page3 = 1
        elsif @current_page2%10 == 1
         @current_page3 = @current_page2
        elsif @current_page2%10 == 0
         @current_page3 = @current_page2 - 9
        else
         @current_page3 = @current_page2 - (@current_page2%10 - 1)
        end 
        @totalpage = @totalpagelist[@current_page3-1..@current_page3+8]
 
    end
        
            
    def lecture_info
        if user_signed_in?
            @temp = Evaluation.where(subject_id: params[:id])
            @previous_semester = Evaluation.where(subject_id: params[:id], lecture_semester: '2015년/2학기')
            @pre_previous_semester = Evaluation.where(subject_id: params[:id], lecture_semester: '2015년/1학기')
            @evaluation_overall5 = Evaluation.where(subject_id: params[:id], score_overall: 10)
            @evaluation_overall4 = Evaluation.where(subject_id: params[:id], score_overall: 8)
            @evaluation_overall3 = Evaluation.where(subject_id: params[:id], score_overall: 6)
            @evaluation_overall2 = Evaluation.where(subject_id: params[:id], score_overall: 4)
            @evaluation_overall1 = Evaluation.where(subject_id: params[:id], score_overall: 2)
            
            @subject = params[:id]
                    
            @sum = 0
            @overall     = 0
            @difficulty  = 0
            @grade       = 0
            @study       = 0
            @achievement = 0
            @attendance  = 0    
                
            @temp.each do |total|
                @overall     = @overall + total.score_overall
                @difficulty  = @difficulty + total.score_difficulty
                @grade       = @grade + total.score_grade
                @study       = @study + total.score_study
                @achievement = @achievement + total.score_achievement
                @attendance  = @attendance + total.score_attendance
                @sum         = @sum + 1    
            end
            
            if( @sum == 0 )
                @average_score_overall     = 0    ##총점
                @average_score_difficulty  = 0    ##난이도
                @average_score_grade       = 0    ##학점
                @average_score_study       = 0    ##학습량
                @average_score_achievement = 0    ##성취감
                @average_score_attendance  = 0    ##출석체크
            else            
                @int_average_score_overall     = @overall / @sum      ##평균총점
                @int_average_score_difficulty  = @difficulty / @sum    ##평균난이도
                @int_average_score_grade       = @grade / @sum         ##평균학점
                @int_average_score_study       = @study / @sum         ##평균학습량
                @int_average_score_achievement = @achievement / @sum   ##평균성취감
                @int_average_score_attendance  = @attendance / @sum    ##평균출석체크 
                                
                @average_score_overall     = @overall.to_d / @sum.to_d       ##평균총점
                @average_score_difficulty  = @difficulty.to_d / @sum.to_d    ##평균난이도
                @average_score_grade       = @grade.to_d / @sum.to_d         ##평균학점
                @average_score_study       = @study.to_d / @sum.to_d         ##평균학습량
                @average_score_achievement = @achievement.to_d / @sum.to_d   ##평균성취감
                @average_score_attendance  = @attendance.to_d / @sum.to_d    ##평균출석체크
            end
        else
            redirect_to '/users/sign_in'
        end
    end
    
    def lecture_info2
        if user_signed_in?
            @temp = Evaluation.where(subject_id: params[:id])
            @previous_semester = Evaluation.where(subject_id: params[:id], lecture_semester: '2015년/2학기')
            @pre_previous_semester = Evaluation.where(subject_id: params[:id], lecture_semester: '2015년/1학기')
            @evaluation_overall5 = Evaluation.where(subject_id: params[:id], score_overall: 10)
            @evaluation_overall4 = Evaluation.where(subject_id: params[:id], score_overall: 8)
            @evaluation_overall3 = Evaluation.where(subject_id: params[:id], score_overall: 6)
            @evaluation_overall2 = Evaluation.where(subject_id: params[:id], score_overall: 4)
            @evaluation_overall1 = Evaluation.where(subject_id: params[:id], score_overall: 2)
            
            @subject = params[:id]
                    
            @sum = 0
            @overall     = 0
            @difficulty  = 0
            @grade       = 0
            @study       = 0
            @achievement = 0
            @attendance  = 0    
                
            @temp.each do |total|
                @overall     = @overall + total.score_overall
                @difficulty  = @difficulty + total.score_difficulty
                @grade       = @grade + total.score_grade
                @study       = @study + total.score_study
                @achievement = @achievement + total.score_achievement
                @attendance  = @attendance + total.score_attendance
                @sum         = @sum + 1    
            end
            
            if( @sum == 0 )
                @average_score_overall     = 0    ##총점
                @average_score_difficulty  = 0    ##난이도
                @average_score_grade       = 0    ##학점
                @average_score_study       = 0    ##학습량
                @average_score_achievement = 0    ##성취감
                @average_score_attendance  = 0    ##출석체크
            else            
                @int_average_score_overall     = @overall / @sum      ##평균총점
                @int_average_score_difficulty  = @difficulty / @sum    ##평균난이도
                @int_average_score_grade       = @grade / @sum         ##평균학점
                @int_average_score_study       = @study / @sum         ##평균학습량
                @int_average_score_achievement = @achievement / @sum   ##평균성취감
                @int_average_score_attendance  = @attendance / @sum    ##평균출석체크 
                                
                @average_score_overall     = @overall.to_d / @sum.to_d       ##평균총점
                @average_score_difficulty  = @difficulty.to_d / @sum.to_d    ##평균난이도
                @average_score_grade       = @grade.to_d / @sum.to_d         ##평균학점
                @average_score_study       = @study.to_d / @sum.to_d         ##평균학습량
                @average_score_achievement = @achievement.to_d / @sum.to_d   ##평균성취감
                @average_score_attendance  = @attendance.to_d / @sum.to_d    ##평균출석체크
            end
        else
            redirect_to '/users/sign_in'
        end
    end
    
    def lecture_info3
        if user_signed_in?
            @temp = Evaluation.where(subject_id: params[:id])
            @previous_semester = Evaluation.where(subject_id: params[:id], lecture_semester: '2015년/2학기')
            @pre_previous_semester = Evaluation.where(subject_id: params[:id], lecture_semester: '2015년/1학기')
            @evaluation_overall5 = Evaluation.where(subject_id: params[:id], score_overall: 10)
            @evaluation_overall4 = Evaluation.where(subject_id: params[:id], score_overall: 8)
            @evaluation_overall3 = Evaluation.where(subject_id: params[:id], score_overall: 6)
            @evaluation_overall2 = Evaluation.where(subject_id: params[:id], score_overall: 4)
            @evaluation_overall1 = Evaluation.where(subject_id: params[:id], score_overall: 2)
            
            @subject = params[:id]
                    
            @sum = 0
            @overall     = 0
            @difficulty  = 0
            @grade       = 0
            @study       = 0
            @achievement = 0
            @attendance  = 0    
                
            @temp.each do |total|
                @overall     = @overall + total.score_overall
                @difficulty  = @difficulty + total.score_difficulty
                @grade       = @grade + total.score_grade
                @study       = @study + total.score_study
                @achievement = @achievement + total.score_achievement
                @attendance  = @attendance + total.score_attendance
                @sum         = @sum + 1    
            end
            
            if( @sum == 0 )
                @average_score_overall     = 0    ##총점
                @average_score_difficulty  = 0    ##난이도
                @average_score_grade       = 0    ##학점
                @average_score_study       = 0    ##학습량
                @average_score_achievement = 0    ##성취감
                @average_score_attendance  = 0    ##출석체크
            else            
                @int_average_score_overall     = @overall / @sum      ##평균총점
                @int_average_score_difficulty  = @difficulty / @sum    ##평균난이도
                @int_average_score_grade       = @grade / @sum         ##평균학점
                @int_average_score_study       = @study / @sum         ##평균학습량
                @int_average_score_achievement = @achievement / @sum   ##평균성취감
                @int_average_score_attendance  = @attendance / @sum    ##평균출석체크 
                                
                @average_score_overall     = @overall.to_d / @sum.to_d       ##평균총점
                @average_score_difficulty  = @difficulty.to_d / @sum.to_d    ##평균난이도
                @average_score_grade       = @grade.to_d / @sum.to_d         ##평균학점
                @average_score_study       = @study.to_d / @sum.to_d         ##평균학습량
                @average_score_achievement = @achievement.to_d / @sum.to_d   ##평균성취감
                @average_score_attendance  = @attendance.to_d / @sum.to_d    ##평균출석체크
            end
        else
            redirect_to '/users/sign_in'
        end
    end
    
    
    def test
    end  

end
