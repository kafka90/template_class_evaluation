class Password < Devise::Mailer 
    include Devise::Mailers::Helpers
    def reset_password_instructions(record, token, opts={})
      @token = token
      devise_mail(record, :reset_password_instructions, opts)
    end
end