class MainController < ApplicationController
    def main
        if user_signed_in?
#            if ( current_user.check_myinfo == 0 )
#                my_evaluation = Myeval.new
#                my_evaluation.user_name = current_user.name 
#                my_evaluation.user_id = current_user.id
#                my_evaluation.save           
#                current_user.update_attribute(:check_myinfo, 1)
#            end
            
            if( current_user.std_num[0..5] == "201631" )
                current_user.update_attribute(:authentication, 2)
            end
            
            if ( current_user.std_num_secret == "" )
                @convert_std_num = ""
                @convert_std_num = current_user.std_num.slice(0..3) + "******"
                current_user.update_attribute(:std_num_secret, @convert_std_num)
            end
        else
            redirect_to '/users/sign_in'
        end
    
        @find_evaluation = Evaluation.all 
        @recent_evaluation = Evaluation.last.id
        @recent_notice = Notice.last
    end 
    
    def main2
        if user_signed_in?
            if ( current_user.check_myinfo == 0 )
                my_evaluation = Myeval.new
                my_evaluation.user_name = current_user.name 
                my_evaluation.user_id = current_user.id
                my_evaluation.save
                
                current_user.update_attribute(:check_myinfo, 1)
            end
            
            if( current_user.std_num[0..5] == "201631" )
                current_user.update_attribute(:authentication, 2)
            end
            
            if ( current_user.std_num_secret == "" )
                @convert_std_num = current_user.std_num.slice(0..3) + "******"
                current_user.update_attribute(:std_num_secret, @convert_std_num)
            end
        else
            redirect_to '/users/sign_in'
        end
    
        @find_evaluation = Evaluation.all 
        @recent_evaluation = Evaluation.last.id
        @recent_notice = Notice.last
    end 
    
    def main_test 
        if user_signed_in? 
            redirect_to '/main/main'
        else
            redirect_to '/users/sign_in'
        end
    end
    
    def chat
    end
    
    def test
    end 
    
    def chat2
    end
end
