class Confirm < ApplicationMailer
    
    def confirm_email ggobsari_1_mail, ggobsari_2_content    
         mail from: 'likelion.skklab@gmail.com', 
                to: ggobsari_1_mail, 
           subject: '[SKK:LAB]성균인 인증 메일입니다',
              body: '인증코드 : ' + ggobsari_2_content 
    end 
    

end
