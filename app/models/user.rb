class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :evalstatuses
  has_many :subjects, through: :evalstatuses

#  def email_required?
#    false
#  end
  
#  def email_changed?
#    false
#  end
    
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
        
        validates_format_of    :std_num, :with  => Devise.email_regexp, message: "옳지 않은 학번입니다      "
        validates_uniqueness_of  :name, message: "이미 존재하는 닉네임입니다"
        validates_uniqueness_of  :std_num, message: "이미 존재하는 학번입니다"
        validates_uniqueness_of  :i_d, message: "이미 존재하는 킹고ID입니다"
        validates_presence_of    :i_d, message: "킹고ID를 작성해주세요          "
        validates_presence_of    :password, message: "비밀번호를 작성해주세요            "
        validates_presence_of    :name, message: "닉네임을 작성해주세요                 "
        validates_confirmation_of :password, message: "비밀번호가 일치하지 않습니다          "
        validates_length_of      :password, :within => Devise.password_length, message: "8자 이상 입력해 주세요"
        validates_length_of      :std_num, is:10, message: "10자리를 입력해주세요 "
end
