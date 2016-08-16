class Report < ApplicationMailer
    def report_email ggobsari_1_username, ggobsari_2_mail, ggobsari_3_title, ggobsari_4_content, ggobsari_5_id    
         mail from: ggobsari_2_mail, 
                to: 'likelion.skklab@gmail.com', 
           subject: '[성대강평신고글] 신고자 : ' + ggobsari_1_username + ' / 제목 : ' + ggobsari_3_title,
              body: '(신고한 강평DB ID : '+ ggobsari_5_id + ')' + ' 신고내용 : ' + ggobsari_4_content 
    end
end
