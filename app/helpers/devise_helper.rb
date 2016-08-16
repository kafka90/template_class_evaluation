# module DeviseHelper
#   def devise_error_messages!
#   return '' if resource.errors.empty?

#   messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
#   sentence = I18n.t('errors.messages.not_saved',
#   count: resource.errors.count,
#   resource: resource.class.model_name.human.downcase)

#   html = <<-HTML
#   <script>
#     alert("#{messages}")
#   </script>
#       <button type="button" class="close" data-dismiss="alert">x</button>
#       #{messages}
     
#   HTML

#   html.html_safe
#   end
# end



# module DeviseHelper
#   def devise_error_messages!
#     return '' if resource.errors.empty?

#     messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

#     html = <<-HTML
#       <button type="button" class="close" data-dismiss="alert">x</button>
#       #{messages}
#     HTML

#     html.html_safe
#   end
# end

# ------------------------------------알람띄우기
# module DeviseHelper
#   def devise_error_messages!
#     return '' if resource.errors.empty?

#     # messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
#     messages = resource.errors.full_messages.first
#     html = <<-HTML
#     <script>
#     <div id="error_explanation">
      
#       <ul>#{messages}</ul>
#     </div>
#     alert("#{messages}")
    
#     </script>
  
#     HTML

#     html.html_safe
#   end
# end


  # <div class="alert alert-error alert-block"> <button type="button"
  #   class="close" data-dismiss="alert">x</button>
  #     #{messages}
  #   </div>
  
  
  
  module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

  end

# module DeviseHelper
#   def devise_error_messages!
#     return '' if resource.errors.empty?

#     messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
#     html = <<-HTML
#     <div class="alert alert-error alert-block"> <button type="button"
#     class="close" data-dismiss="alert">x</button>
#       #{messages}
#     </div>
#     HTML

#     html.html_safe
#   end
# end