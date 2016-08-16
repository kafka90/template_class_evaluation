class DeviseCreateUsers < ActiveRecord::Migration  
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      
      ##추가 (이름, 학번, 평가한 과목의 개수)
      t.string  :name,                null: false, default: "", unique: true      #이름
      t.string  :std_num,             null: false, default: ""                    #학번     => ex)2010111111
      t.string  :std_num_secret,      null: false, default: ""                    #학번익명 => ex)2010******
      
      t.string  :confirm_code,        null: false, default: ""      #인증코드   
      t.integer :authentication,      null: false, default: 0       #인증여부(0:아직 인증시도조차 안한 경우/1:인증실패/2:인증완료/3:운영진)
      
      t.integer :check_myinfo,        null: false, default: 0                         
      t.string  :list_myeval,         null: false, default: ""      #평가한 강평id를 string형태로 저장
      
      t.integer :overall_num_myeval,  null: false, default: 0       #작성한 총 강평 개수
      t.integer :num_myeval,          null: false, default: 0       #이번학기 작성한 강평 개수-->매학기 0으로 리셋
      t.integer :num_myreport,        null: false, default: 0       #작성한 신고/문의 개수
     
      t.string :i_d,                  null: false, default: ""      #가입시 입력한 킹고ID                               
      t.string :email,                null: true, default: ""       #성균관대학교 email
      t.string :encrypted_password,   null: false, default: ""
      
      ##chat
      t.string :token1,               null: false, default: ""
    
    
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

   # add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
  
end
