class NoticeController < ApplicationController

    def notice_board
        if user_signed_in?
            @no = Notice.all
        else
            redirect_to '/users/sign_in'
        end
    end
    
    
    def notice_detail
        if user_signed_in?
            @this_article = Notice.find(params[:id])
        else
            redirect_to '/users/sign_in'
        end
    end
    
    
    def notice_modify
        @this_article = Notice.find(params[:id])
    end
    
    
    def notice_modify_action  
        nm= Notice.where(:id => params[:m_id]).take
        nm.notice_title= params[:m_title]
        nm.notice_article= params[:m_contents]
        nm.save
        k = nm.id
        redirect_to '/notice/notice_board/'
    end
    
    
    def notice_write
    end
    
    def notice_write_action
        na =Notice.new
        na.notice_article  =params[:n_contents]
        na.notice_title    =params[:n_title]
        na.notice_password =params[:n_password]
        na.notice_writer   =current_user.name
        na.save
        redirect_to '/notice/notice_board'
    end
    
    def notice_delete
        @this_post= Notice.find(params[:id])
    end
    
    def notice_delete_process         
        @flag=0
        @this_post = Notice.find(params[:id]) 
        match = params[:delete_password] 
        if (@this_post.notice_password==match)
            @flag=1
            @this_post.destroy
            
            redirect_to '/notice/notice_board'       
        else
            @flag = 0      
        end          
    end
    
    
    
    
        
end
