class Contact < ApplicationMailer
    def contact_email ggobsari_1_username, ggobsari_2_mail, ggobsari_3_title, ggobsari_4_content    
         mail from: ggobsari_2_mail, 
                to: 'likelion.skklab@gmail.com', 
           subject: '[성대강평문의글]' + ggobsari_1_username + '/' + ggobsari_3_title,
              body: ggobsari_4_content 
    end
end
